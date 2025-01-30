import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AjouterCompagniePage extends StatefulWidget {
  const AjouterCompagniePage({super.key});

  @override
  _AjouterCompagniePageState createState() => _AjouterCompagniePageState();
}

class _AjouterCompagniePageState extends State<AjouterCompagniePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final TextEditingController _siegeController = TextEditingController();
  final TextEditingController _logoController = TextEditingController();

  bool _loading = false;

  Future<void> _ajouterCompagnie() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });

      try {
        // 🔹 Étape 1 : Ajouter la compagnie à Firestore
        DocumentReference compagnieRef = await FirebaseFirestore.instance.collection('compagnie').add({
          'nom': _nomController.text.trim(),
          'email': _emailController.text.trim(),
          'telephone': _telephoneController.text.trim(),
          'siege_social': _siegeController.text.trim(),
          'logo': _logoController.text.trim(),
          'statut': 'actif',
          'date_inscription': DateTime.now().toIso8601String(),
        });

        String compagnieId = compagnieRef.id; // 🔹 Récupération de l'ID de la compagnie

        // 🔹 Étape 2 : Ajouter l'utilisateur correspondant à Firebase Auth
        String email = _emailController.text.trim();
        String password = "compagni@123"; // 🔹 Mot de passe temporaire

        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String userId = userCredential.user!.uid; // 🔹 Récupération de l'ID utilisateur

        // 🔹 Étape 3 : Enregistrer l'utilisateur dans la collection Firestore "utilisateurs"
        await FirebaseFirestore.instance.collection('utilisateurs').doc(userId).set({
          'nom': _nomController.text.trim(),
          'email': email,
          'telephone': _telephoneController.text.trim(),
          'role_id': '2', // 🔹 2 = Compagnie
          'compagnie_id': compagnieId, // 🔹 Lien avec la compagnie
          'date_creation': DateTime.now().toIso8601String(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Compagnie ajoutée avec succès 🎉'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context); // 🔹 Retourner à la liste des compagnies
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }

      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une Compagnie 🏢'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_nomController, "Nom de la compagnie", Icons.business, true),
              _buildTextField(_emailController, "Email", Icons.email, true),
              _buildTextField(_telephoneController, "Téléphone", Icons.phone, true),
              _buildTextField(_siegeController, "Siège Social", Icons.location_city, true),
              _buildTextField(_logoController, "URL du Logo", Icons.image, false),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _loading ? null : _ajouterCompagnie,
                icon: Icon(Icons.check, size: 24),
                label: Text(
                  _loading ? 'Ajout en cours...' : 'Ajouter Compagnie',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, bool required) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        validator: required
            ? (value) => value!.isEmpty ? 'Ce champ est obligatoire' : null
            : null,
        decoration: InputDecoration(
          labelText: hint,
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
