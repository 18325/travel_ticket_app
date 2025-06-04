// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';

// class AjouterVoyageurPage extends StatefulWidget {
//   const AjouterVoyageurPage({super.key});

//   @override
//   _AjouterVoyageurPageState createState() => _AjouterVoyageurPageState();
// }


// class _AjouterVoyageurPageState extends State<AjouterVoyageurPage> {
//   final TextEditingController _nomController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _telephoneController = TextEditingController();
//   final TextEditingController _adresseController = TextEditingController();
//   final TextEditingController _dateNaissanceController = TextEditingController();
//   final TextEditingController _photoProfilController = TextEditingController();

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Fonction pour générer un mot de passe aléatoire
//   String _generateRandomPassword() {
//     const length = 12;
//     const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()';
//     Random random = Random();
//     return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
//   }

//   Future<void> _ajouterVoyageur() async {
//     try {
//       String userId = _auth.currentUser!.uid;
//       String password = _generateRandomPassword(); // Générer le mot de passe aléatoire

//       // Créer l'utilisateur Firebase Authentication
//       UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: password,
//       );

//       // Ajouter les informations du voyageur dans Firestore
//       await _firestore.collection('voyageur').add({
//         'userId': userCredential.user!.uid,
//         'nom': _nomController.text.trim(),
//         'email': _emailController.text.trim(),
//         'telephone': _telephoneController.text.trim(),
//         'adresse': _adresseController.text.trim(),
//         'date_naissance': _dateNaissanceController.text.trim(),
//         'photo_profil': _photoProfilController.text.trim(),
//         'statut': 'actif',
//         'programme_fidelite': {
//           'points': 0,
//           'niveau': 'Bronze',
//         },
//         'date_inscription': DateTime.now().toIso8601String(),
//       });

//       // Envoyer un email contenant les informations de connexion
//       final Email email = Email(
//         body: 'Votre compte a été créé avec succès.\n\n'
//             'Email: ${_emailController.text.trim()}\n'
//             'Mot de passe: $password\n\n'
//             'Vous pouvez maintenant vous connecter.',
//         subject: 'Informations de connexion',
//         recipients: [_emailController.text.trim()],
//         isHTML: false,
//       );
//       await FlutterEmailSender.send(email);

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Voyageur ajouté avec succès!')),
//       );

//       Navigator.pop(context);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Erreur : ${e.toString()}')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Ajouter un Voyageur"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             TextField(
//               controller: _nomController,
//               decoration: const InputDecoration(labelText: 'Nom Complet'),
//             ),
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: _telephoneController,
//               decoration: const InputDecoration(labelText: 'Téléphone'),
//             ),
//             TextField(
//               controller: _adresseController,
//               decoration: const InputDecoration(labelText: 'Adresse'),
//             ),
//             TextField(
//               controller: _dateNaissanceController,
//               decoration: const InputDecoration(labelText: 'Date de Naissance'),
//             ),
//             TextField(
//               controller: _photoProfilController,
//               decoration: const InputDecoration(labelText: 'URL Photo de Profil'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _ajouterVoyageur,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange.shade800,
//               ),
//               child: const Text('Ajouter Voyageur'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
