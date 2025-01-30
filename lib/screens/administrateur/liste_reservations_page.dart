import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_ticket_app/models/reservation.dart';
import 'package:travel_ticket_app/screens/administrateur/detail_reservation_page.dart';

class ListeReservationsPage extends StatelessWidget {
  const ListeReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des Réservations"),
        backgroundColor: Colors.blueAccent,
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          }

          var reservations = snapshot.data!.docs
              .map((doc) => ReservationModel.fromFirestore(doc))
              .toList();

          return ListView.builder(
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              ReservationModel reservation = reservations[index];

              // Formatage de la date
              String formattedDate = DateFormat('dd MMM yyyy HH:mm', 'fr_FR')
                  .format(reservation.dateReservation.toDate());

              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      reservation.id.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    'Réservation #${reservation.id}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Date : $formattedDate\n'
                    'Prix Total : ${reservation.prixTotal} €\n'
                    'Statut : Confirmée',
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailReservationPage(reservation: reservation),
                      ),
                      );
                    },

                ),
              );
            },
          );
        },
      ),
    );
  }
}
