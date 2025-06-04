import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AjouterVoyagePage extends StatefulWidget {
  const AjouterVoyagePage({super.key});

  @override
  _AjouterVoyagePageState createState() => _AjouterVoyagePageState();
}

class _AjouterVoyagePageState extends State<AjouterVoyagePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _villeDepartController = TextEditingController();
  final TextEditingController _villeArriveeController = TextEditingController();
  final TextEditingController _dateDepartController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  final TextEditingController _placesController = TextEditingController();
  final TextEditingController _typeTransportController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _ajouterVoyage() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _firestore.collection('voyages').add({
          'ville_depart': _villeDepartController.text,
          'ville_arrivee': _villeArriveeController.text,
          'date_depart': _dateDepartController.text,
          'prix': double.parse(_prixController.text),
          'places_disponibles': int.parse(_placesController.text),
          'type_transport': _typeTransportController.text,
          'created_at': DateTime.now().toIso8601String(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Voyage ajouté avec succès!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: ${e.toString()}'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ajouter un Voyage",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                controller: _villeDepartController,
                label: "Ville de départ",
                icon: Icons.location_on,
              ),
              _buildTextField(
                controller: _villeArriveeController,
                label: "Ville d'arrivée",
                icon: Icons.location_city,
              ),
              _buildTextField(
                controller: _dateDepartController,
                label: "Date de départ",
                icon: Icons.calendar_today,
              ),
              _buildTextField(
                controller: _prixController,
                label: "Prix",
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                controller: _placesController,
                label: "Places disponibles",
                icon: Icons.people,
                keyboardType: TextInputType.number,
              ),
              _buildTextField(
                controller: _typeTransportController,
                label: "Type de transport",
                icon: Icons.directions_bus,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _ajouterVoyage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  shadowColor: Colors.blueAccent.withOpacity(0.3),
                ),
                child: Text(
                  "Ajouter le voyage",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey),
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
          ),
        ),
        keyboardType: keyboardType,
        validator: (value) => value!.isEmpty ? "Champ requis" : null,
      ),
    );
  }
}