import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_ticket_app/models/voyageur.dart';

class AjouterVoyageurPage extends StatefulWidget {
  const AjouterVoyageurPage({super.key});

  @override
  _AjouterVoyageurPageState createState() => _AjouterVoyageurPageState();
}

class _AjouterVoyageurPageState extends State<AjouterVoyageurPage> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _dateNaissanceController = TextEditingController();
  final TextEditingController _photoProfilController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _ajouterVoyageur() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      await _firestore.collection('voyageur').add({
        'userId': userId,
        'nom': _nomController.text,
        'email': _emailController.text,
        'telephone': _telephoneController.text,
        'adresse': _adresseController.text,
        'date_naissance': _dateNaissanceController.text,
        'photo_profil': _photoProfilController.text,
        'statut': 'actif', // Par défaut, actif
        'programme_fidelite': {
          'points': 0,
          'niveau': 'Bronze',
        },
        'date_inscription': DateTime.now().toIso8601String(),
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Voyageur ajouté avec succès!')));
      Navigator.pop(context);
    } catch (e) {
      print('Erreur : $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de l\'ajout du voyageur.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter un Voyageur"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nomController,
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _telephoneController,
              decoration: InputDecoration(labelText: 'Téléphone'),
            ),
            TextField(
              controller: _adresseController,
              decoration: InputDecoration(labelText: 'Adresse'),
            ),
            TextField(
              controller: _dateNaissanceController,
              decoration: InputDecoration(labelText: 'Date de Naissance'),
            ),
            TextField(
              controller: _photoProfilController,
              decoration: InputDecoration(labelText: 'URL Photo de Profil'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _ajouterVoyageur,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade800,
              ),
              child: Text('Ajouter Voyageur'),
            ),
          ],
        ),
      ),
    );
  }
}
