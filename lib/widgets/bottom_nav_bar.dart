import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final String roleId; // Le rôle de l'utilisateur (1 = Voyageur, 2 = Compagnie, 3 = Administrateur)

  BottomNavBar({required this.roleId});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Icône 1 : Accueil
            IconButton(
              icon: Icon(Icons.home_outlined, size: 28),
              color: Colors.blue,
              onPressed: () {
                // Logique pour rediriger vers une page Accueil
                if (roleId == '1') {
                  print('Naviguer vers Accueil Voyageur');
                } else if (roleId == '2') {
                  print('Naviguer vers Accueil Compagnie');
                } else if (roleId == '3') {
                  print('Naviguer vers Accueil Administrateur');
                }
              },
            ),
            // Icône 2 : Section spécifique (par rôle)
            IconButton(
              icon: Icon(Icons.list_alt_outlined, size: 28),
              color: Colors.orange,
              onPressed: () {
                // Logique pour rediriger vers une page spécifique
                if (roleId == '1') {
                  print('Naviguer vers Réservations (Voyageur)');
                } else if (roleId == '2') {
                  print('Naviguer vers Gestion des Voyages (Compagnie)');
                } else if (roleId == '3') {
                  print('Naviguer vers Gestion des Utilisateurs (Admin)');
                }
              },
            ),
            // Icône 3 : Statistiques (par rôle)
            IconButton(
              icon: Icon(Icons.bar_chart_outlined, size: 28),
              color: Colors.green,
              onPressed: () {
                // Logique pour rediriger vers une page Statistiques
                if (roleId == '1') {
                  print('Naviguer vers Statistiques (Voyageur)');
                } else if (roleId == '2') {
                  print('Naviguer vers Statistiques des Voyages (Compagnie)');
                } else if (roleId == '3') {
                  print('Naviguer vers Statistiques Globales (Admin)');
                }
              },
            ),
            // Icône 4 : Paramètres
            IconButton(
              icon: Icon(Icons.settings_outlined, size: 28),
              color: Colors.grey,
              onPressed: () {
                // Logique pour rediriger vers une page Paramètres
                print('Naviguer vers Paramètres');
              },
            ),
          ],
        ),
      ),
    );
  }
}
