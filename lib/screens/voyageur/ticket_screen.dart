import 'package:flutter/material.dart';
import 'package:travel_ticket_app/models/reservation.dart';

class TicketScreen extends StatelessWidget {
  final ReservationModel reservation;

  const TicketScreen({Key? key, required this.reservation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Votre billet'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Code du billet: ${reservation.codeTicket}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Date de réservation: ${reservation.dateReservation.toDate()}'),
            SizedBox(height: 20),
            Text('Prix total: ${reservation.prixTotal} €'),
            // Ajoutez d'autres détails du billet ici...
          ],
        ),
      ),
    );
  }
}
