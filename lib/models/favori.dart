import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_ticket_app/models/reservation.dart';
import 'package:travel_ticket_app/models/voyage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart'; // Pour générer des UUID

// Nouveau modèle pour les favoris
class Favori {
  final String voyageId;
  final String userId;

  Favori({required this.voyageId, required this.userId});

  Map<String, dynamic> toMap() {
    return {
      'voyage_id': voyageId,
      'user_id': userId,
    };
  }
}


class ReservationDetailsScreen extends StatefulWidget {
  final VoyageModel voyage;

  const ReservationDetailsScreen({Key? key, required this.voyage, required String reservationId}) : super(key: key);

  @override
  _ReservationDetailsScreenState createState() => _ReservationDetailsScreenState();
}

class _ReservationDetailsScreenState extends State<ReservationDetailsScreen> {
  int _selectedPlaces = 1;
  bool _isFavorite = false; // État pour gérer l'icône de favori

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus(); // Vérifier le statut de favori au chargement
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


  Future<void> _toggleFavorite() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (_isFavorite) {
        // Supprimer des favoris
         await FirebaseFirestore.instance
            .collection('favoris')
             .where('voyage_id', isEqualTo: widget.voyage.id)
            .where('user_id', isEqualTo: user.uid)
            .get()
            .then((snapshot) {
              for (DocumentSnapshot doc in snapshot.docs) {
               doc.reference.delete();
             }
           });


      } else {
        // Ajouter aux favoris
        final favori = Favori(voyageId: widget.voyage.id, userId: user.uid);
        await FirebaseFirestore.instance.collection('favoris').add(favori.toMap());



      }
      setState(() {
        _isFavorite = !_isFavorite;
      });

         ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_isFavorite ? 'Ajouté aux favoris' : 'Retiré des favoris')),
          );
    }

  }





  Future<void> _makeReservation(int places) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vous devez être connecté")));
        return;
      }

      final uuid = Uuid(); // Générer un code unique avec uuid
      final newReservation = ReservationModel(
        codeTicket: uuid.v4(), // Utiliser l'UUID comme code de ticket
        dateReservation: Timestamp.now(),
        id: 0,
        prixTotal: widget.voyage.prix.toInt() * places,
        voyageId: int.parse(widget.voyage.id),
        voyageurId: int.parse(user.uid),
      );

      await FirebaseFirestore.instance.collection('reservations').add(newReservation.toFirestore());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Réservation réussie !'),
          backgroundColor: Colors.green,
        ),
      );

      // Afficher les détails de la réservation
      _showReservationDetails(newReservation);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de la réservation. Veuillez réessayer.'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error making reservation: $e');
    }
  }


void _showReservationDetails(ReservationModel reservation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Détails de la réservation'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Pour éviter que la boîte de dialogue ne prenne tout l'écran
            children: [
              Text('Code du ticket: ${reservation.codeTicket}'),
              Text('Date de réservation: ${reservation.dateReservation.toDate()}'),
              Text('Prix total: ${reservation.prixTotal}'),
              // ... autres détails de la réservation
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
                Navigator.of(context).pop(); // Revenir à l'écran précédent
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la réservation'),
        actions: [
          IconButton(
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border), // Icône dynamique
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      // ... (reste du code inchangé)

    );
  }
}
