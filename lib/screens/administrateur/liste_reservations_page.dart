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
        title: const Text("Réservations"),
        backgroundColor: Colors.purple.shade700,
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
            padding: const EdgeInsets.all(16),
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              ReservationModel reservation = reservations[index];
              String formattedDate = DateFormat('dd MMM yyyy HH:mm', 'fr_FR')
                  .format(reservation.dateReservation.toDate());

              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: Icon(Icons.airplane_ticket, color: Colors.purple.shade700, size: 28),
                  title: Text(
                    'Réservation #${reservation.id}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Date : $formattedDate\nPrix Total : ${reservation.prixTotal} €"),
                  trailing: IconButton(
                    icon: Icon(Icons.visibility, color: Colors.purple.shade700),
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
