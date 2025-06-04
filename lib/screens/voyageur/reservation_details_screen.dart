import 'package:flutter/material.dart';
import 'package:travel_ticket_app/models/voyage.dart';
import 'package:travel_ticket_app/screens/voyageur/payment_screen.dart'; 

class ReservationDetailsScreen extends StatefulWidget {
  final VoyageModel voyage;

  const ReservationDetailsScreen({Key? key, required this.voyage}) : super(key: key);

  @override
  _ReservationDetailsScreenState createState() => _ReservationDetailsScreenState();
}

class _ReservationDetailsScreenState extends State<ReservationDetailsScreen> {
  int _selectedPlaces = 1;

  void _redirectToPaymentScreen() {
    // Rediriger vers la page de paiement sans données
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PaymentScreen(
          totalAmount: 0.0,  // Aucun montant
          codeTicket: '',    // Aucun code de ticket
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du Voyage'),
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
                  onPressed: () {
                    // Cette partie est pour réserver mais dans ce cas on ne crée rien
                  },
                  child: const Center(child: Text('Réserver', style: TextStyle(fontSize: 18, color: Colors.white))),
                ),
                SizedBox(height: 15),
                // Nouveau bouton "Payer immédiatement"
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: _redirectToPaymentScreen, // Redirection vers la page de paiement sans données
                  child: const Center(
                    child: Text('Payer immédiatement', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
