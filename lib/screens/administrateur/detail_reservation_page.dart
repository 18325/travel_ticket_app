import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_ticket_app/models/reservation.dart';

class DetailReservationPage extends StatelessWidget {
  final ReservationModel reservation;

  const DetailReservationPage({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd MMMM yyyy à HH:mm', 'fr_FR')
        .format(reservation.dateReservation.toDate());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails de la réservation"),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 6,
            shadowColor: Colors.deepPurpleAccent,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.airplane_ticket, color: Colors.deepPurpleAccent, size: 28),
                      Text(
                        "Code Ticket : ${reservation.codeTicket}",
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),
                    ],
                  ),
                  const Divider(thickness: 1.5, height: 20),
                  infoTile(Icons.person, "Voyageur ID", reservation.voyageId.toString()),
                  infoTile(Icons.directions_bus, "Voyage ID", reservation.voyageId.toString()),
                  infoTile(Icons.attach_money, "Prix total", "${reservation.prixTotal} FCFA", Colors.green),
                  infoTile(Icons.calendar_today, "Date de réservation", formattedDate, Colors.blueAccent),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text("Retour"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        elevation: 3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget infoTile(IconData icon, String label, String value, [Color? color]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: color ?? Colors.black54, size: 22),
          const SizedBox(width: 10),
          Text(
            "$label : ",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 18, color: color ?? Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
