import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_ticket_app/models/reservation.dart';
import 'package:travel_ticket_app/models/voyageur.dart';
import 'package:travel_ticket_app/screens/administrateur/detail_reservation_page.dart';


class ListeReservationsPage extends StatelessWidget {
  const ListeReservationsPage({super.key});

  Future<VoyageurModel?> getVoyageurInfo(String voyageurId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('voyageur')
          .doc(voyageurId)
          .get();

      if (snapshot.exists) {
        return VoyageurModel.fromFirestore(snapshot);
      }
    } catch (e) {
      print("Erreur lors de la récupération du voyageur : $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Réservations"),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('reservations').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'Aucune réservation trouvée',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            );
          }

          var reservations = snapshot.data!.docs.map((doc) => ReservationModel.fromFirestore(doc)).toList();

          return ListView.builder(
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              ReservationModel reservation = reservations[index];
              String formattedDate = DateFormat('dd MMM yyyy HH:mm', 'fr_FR')
                  .format(reservation.dateReservation.toDate());

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.airplane_ticket, color: Colors.deepPurpleAccent, size: 28),
                  title: Text(
                    'Réservation #${reservation.id}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date : $formattedDate"),
                      Text("Prix Total : ${reservation.prixTotal} €", style: const TextStyle(color: Colors.green)),
                      FutureBuilder<VoyageurModel?>(
                        future: getVoyageurInfo(reservation.voyageurId.toString()),
                        builder: (context, voyageurSnapshot) {
                          if (voyageurSnapshot.connectionState == ConnectionState.waiting) {
                            return const Text("Chargement du voyageur...", style: TextStyle(color: Colors.grey));
                          } else if (voyageurSnapshot.hasError || voyageurSnapshot.data == null) {
                            return const Text("Voyageur inconnu", style: TextStyle(color: Colors.red));
                          } else {
                            return Text("Voyageur : ${voyageurSnapshot.data!.nom}", style: const TextStyle(color: Colors.blueAccent));
                          }
                        },
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.visibility, color: Colors.deepPurpleAccent),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailReservationPage(reservation: reservation),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
