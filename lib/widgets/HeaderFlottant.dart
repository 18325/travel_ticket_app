import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HeaderFlottant extends StatelessWidget {
  final String roleId;

  const HeaderFlottant({super.key, required this.roleId});

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
            // Icône Menu (avec effet de survol et animation)
            IconButton(
              icon: Icon(
                Icons.menu_rounded, 
                color: Colors.white, 
                size: 30, // Taille plus grande pour un meilleur visuel
              ),
              onPressed: () {
                _showMenu(context, roleId); // Afficher le menu en fonction du rôle
              },
            ),
            // Icône de Déconnexion (avec design amélioré)
            IconButton(
              icon: Icon(
                Icons.exit_to_app, 
                color: Colors.redAccent, 
                size: 30, // Taille plus grande pour plus de visibilité
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login'); // Redirige vers la page de login
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
                  leading: Icon(Icons.account_circle, color: Colors.blueAccent, size: 30),
                  title: Text("Profil Voyageur", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  onTap: () {
                    // Naviguer vers le profil voyageur
                  },
                ),
                ListTile(
                  leading: Icon(Icons.bookmark_border, color: Colors.blueAccent, size: 30),
                  title: Text("Mes Réservations", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  onTap: () {
                    // Naviguer vers les réservations
                  },
                ),
              ] else if (roleId == '2') ...[
                ListTile(
                  leading: Icon(Icons.business_rounded, color: Colors.green, size: 30),
                  title: Text("Profil Compagnie", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  onTap: () {
                    // Naviguer vers le profil compagnie
                  },
                ),
                ListTile(
                  leading: Icon(Icons.flight_takeoff_rounded, color: Colors.green, size: 30),
                  title: Text("Mes Voyages", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  onTap: () {
                    // Naviguer vers les voyages
                  },
                ),
                ListTile(
                  leading: Icon(Icons.bar_chart_rounded, color: Colors.green, size: 30),
                  title: Text("Statistiques", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  onTap: () {
                    // Naviguer vers les statistiques
                  },
                ),
              ] else if (roleId == '3') ...[
                ListTile(
                  leading: Icon(Icons.group, color: Colors.orange, size: 30),
                  title: Text("Gestion des Utilisateurs", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  onTap: () {
                    // Naviguer vers la gestion des utilisateurs
                  },
                ),
                ListTile(
                  leading: Icon(Icons.public_rounded, color: Colors.orange, size: 30),
                  title: Text("Statistiques Globales", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
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
