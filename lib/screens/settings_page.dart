import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Section Profil
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profil',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.person, color: Colors.blue), // Changed icon for clarity
                title: const Text('Mon Profil'),                   // Changed text for clarity
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    // screens/settings_page.dart (excerpt - the onTap function)
                    onTap: () async {
                      final currentUser = FirebaseAuth.instance.currentUser;
                      if (currentUser != null) {
                        try {  // Add a try-catch block for error handling
                          final userDoc = await FirebaseFirestore.instance
                              .collection('users')
                              .doc(currentUser.uid)
                              .get();

                          if (userDoc.exists) {
                            Navigator.pushNamed(
                              context,
                              '/userprofile',
                              arguments: UserModel.fromFirestore(userDoc as Map<String, dynamic>),  // Use fromFirestore
                            );
                          } else {
                            // Handle the case where the user document doesn't exist
                            print('User document not found');
                            // Show a snackbar or dialog to the user.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Profil utilisateur introuvable.')),
                            );
                          }
                        } catch (e) {
                          print("Error fetching user data: $e");
                          // Show an error message to the user.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Erreur lors du chargement du profil.')),
                          );
                        }
                      }
                    },

              ),
              ListTile(
                leading: const Icon(Icons.lock, color: Colors.blue),
                title: const Text('Changer le mot de passe'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Naviguer vers l'écran de changement de mot de passe
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Section Notifications
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.notifications, color: Colors.blue),
                title: const Text('Préférences de notifications'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Naviguer vers l'écran des préférences de notifications
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Section Historique
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Historique',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.history, color: Colors.blue),
                title: const Text('Historique des réservations'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.pushNamed(context, '/reservations');
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Section Support
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Support',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.help, color: Colors.blue),
                title: const Text('Centre d\'aide'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Naviguer vers l'écran du centre d'aide
                },
              ),
              ListTile(
                leading: const Icon(Icons.feedback, color: Colors.blue),
                title: const Text('Envoyer des commentaires'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Naviguer vers l'écran des retours utilisateurs
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Section Déconnexion
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Compte',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.blue),
                title: const Text('Déconnexion'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Ajouter la logique de déconnexion ici
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
