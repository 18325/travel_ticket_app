import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_ticket_app/models/reservation.dart';

class DetailReservationPage extends StatelessWidget {
  final ReservationModel reservation;

  const DetailReservationPage({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    // Formater la date proprement
    String formattedDate = DateFormat('dd MMMM yyyy à HH:mm', 'fr_FR')
        .format(reservation.dateReservation.toDate());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails de la réservation"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Code Ticket : ${reservation.codeTicket}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Voyageur ID : ${reservation.voyageurId}"),
            Text("Voyage ID : ${reservation.voyageId}"),
            // Text("Nombre de places : ${reservation.nombrePlaces}"),
            Text("Prix total : ${reservation.prixTotal} €"),
            // Text("Statut : ${reservation.statut}"),
            Text("Date de réservation : $formattedDate"),
          ],
        ),
      ),
    );
  }
}
