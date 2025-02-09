import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_ticket_app/models/reservation.dart';
import 'package:travel_ticket_app/screens/voyageur/ticket_screen.dart';
import 'package:uuid/uuid.dart';
import 'package:lottie/lottie.dart';
import 'package:travel_ticket_app/models/favori.dart';
import 'package:travel_ticket_app/models/voyage.dart';

class ReservationDetailsScreen extends StatefulWidget {
  final VoyageModel voyage;

  const ReservationDetailsScreen({Key? key, required this.voyage}) : super(key: key);

  @override
  _ReservationDetailsScreenState createState() => _ReservationDetailsScreenState();
}

class _ReservationDetailsScreenState extends State<ReservationDetailsScreen> {
  int _selectedPlaces = 1;
  bool _isFavorite = false;
  List<ReservationModel> _userReservations = [];

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
    _loadUserReservations();
  }

  Future<void> _checkFavoriteStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('favoris')
          .where('voyage_id', isEqualTo: widget.voyage.id)
          .where('user_id', isEqualTo: user.uid)
          .get();
      setState(() {
        _isFavorite = snapshot.docs.isNotEmpty;
      });
    }
  }

  Future<void> _loadUserReservations() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('reservations')
          .where('voyageurId', isEqualTo: int.parse(user.uid))
          .get();

      setState(() {
        _userReservations = snapshot.docs.map((doc) {
          return ReservationModel.fromFirestore(doc);
        }).toList();
      });
    }
  }

  Future<void> _makeReservation(int places) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Vous devez être connecté")),
        );
        return;
      }

      final uuid = Uuid();
      final newReservation = ReservationModel(
        codeTicket: uuid.v4(),
        dateReservation: Timestamp.now(),
        id: 0,
        prixTotal: widget.voyage.prix.toInt() * places,
        voyageId: int.parse(widget.voyage.id),
        voyageurId: int.parse(user.uid),
      );

      final batch = FirebaseFirestore.instance.batch();
      final reservationRef = FirebaseFirestore.instance.collection('reservations').doc();
      batch.set(reservationRef, newReservation.toFirestore());

      final favori = Favori(voyageId: widget.voyage.id, userId: user.uid);
      final favoriRef = FirebaseFirestore.instance.collection('favoris').doc();
      batch.set(favoriRef, favori.toMap());
      setState(() {
        _isFavorite = true;
      });

      await batch.commit();
      _loadUserReservations(); // Recharger les réservations après la nouvelle réservation
      _showTicketScreen(newReservation);
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showTicketScreen(ReservationModel reservation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketScreen(reservation: reservation),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du Voyage'),
        actions: [
          IconButton(
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
            onPressed: () async {
              await _makeReservation(_selectedPlaces);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('📍 ${widget.voyage.villeDepart} ➝ ${widget.voyage.villeArrivee}',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    Icon(Icons.airplane_ticket, color: Colors.blueAccent, size: 30),
                  ],
                ),
                Divider(),
                SizedBox(height: 10),
                Text('🗓 Date: ${widget.voyage.dateDepart}',
                    style: TextStyle(fontSize: 18, color: Colors.grey[700])),
                Text('💺 Places disponibles: ${widget.voyage.placesDisponibles}',
                    style: TextStyle(fontSize: 18, color: Colors.grey[700])),
                Text('🚍 Transport: ${widget.voyage.typeTransport}',
                    style: TextStyle(fontSize: 18, color: Colors.grey[700])),
                SizedBox(height: 15),
                Row(
                  children: [
                    const Text('Nombre de places:', style: TextStyle(fontSize: 16)),
                    SizedBox(width: 10),
                    DropdownButton<int>(
                      value: _selectedPlaces,
                      items: List.generate(
                        widget.voyage.placesDisponibles,
                        (i) => DropdownMenuItem<int>(value: i + 1, child: Text('${i + 1}')),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedPlaces = value!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text('💰 Prix total: ${widget.voyage.prix * _selectedPlaces}€',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () => _makeReservation(_selectedPlaces),
                  child: const Center(child: Text('Réserver', style: TextStyle(fontSize: 18, color: Colors.white))),
                ),
                SizedBox(height: 30),
                Text('Vos réservations:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                _userReservations.isEmpty
                    ? Center(child: Text("Aucune réservation trouvée"))
                    : ListView.builder(
                        shrinkWrap: true, // Pour éviter que la ListView ne prenne toute la place
                        itemCount: _userReservations.length,
                        itemBuilder: (context, index) {
                          final reservation = _userReservations[index];
                          return ListTile(
                            title: Text("Réservation: ${reservation.codeTicket}"),
                            subtitle: Text("Date: ${reservation.dateReservation.toDate()}"),
                            trailing: Text("${reservation.prixTotal}€"),
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
