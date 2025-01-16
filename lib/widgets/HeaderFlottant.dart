import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HeaderFlottant extends StatelessWidget {
  final String roleId;

  HeaderFlottant({required this.roleId});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40, // Distance depuis le haut de l'écran
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icône de Déconnexion
            IconButton(
              icon: Icon(Icons.logout, color: Colors.red),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login'); // Redirige vers la page de login
              },
            ),
            // Icône Menu
            IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                _showMenu(context, roleId); // Afficher le menu en fonction du rôle
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showMenu(BuildContext context, String roleId) {
    // Afficher un menu spécifique selon le rôle dans un BottomSheet pour une meilleure expérience
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (roleId == '1') ...[
                ListTile(
                  leading: Icon(Icons.person, color: Colors.blue),
                  title: Text("Profil Voyageur"),
                  onTap: () {
                    // Naviguer vers le profil voyageur
                  },
                ),
                ListTile(
                  leading: Icon(Icons.bookmark, color: Colors.blue),
                  title: Text("Mes Réservations"),
                  onTap: () {
                    // Naviguer vers les réservations
                  },
                ),
              ] else if (roleId == '2') ...[
                ListTile(
                  leading: Icon(Icons.business, color: Colors.green),
                  title: Text("Profil Compagnie"),
                  onTap: () {
                    // Naviguer vers le profil compagnie
                  },
                ),
                ListTile(
                  leading: Icon(Icons.flight_takeoff, color: Colors.green),
                  title: Text("Mes Voyages"),
                  onTap: () {
                    // Naviguer vers les voyages
                  },
                ),
                ListTile(
                  leading: Icon(Icons.bar_chart, color: Colors.green),
                  title: Text("Statistiques"),
                  onTap: () {
                    // Naviguer vers les statistiques
                  },
                ),
              ] else if (roleId == '3') ...[
                ListTile(
                  leading: Icon(Icons.people, color: Colors.orange),
                  title: Text("Gestion des Utilisateurs"),
                  onTap: () {
                    // Naviguer vers la gestion des utilisateurs
                  },
                ),
                ListTile(
                  leading: Icon(Icons.public, color: Colors.orange),
                  title: Text("Statistiques Globales"),
                  onTap: () {
                    // Naviguer vers les statistiques globales
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
