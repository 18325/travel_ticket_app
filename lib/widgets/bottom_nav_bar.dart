import 'package:flutter/material.dart';
import 'package:travel_ticket_app/screens/settings_page.dart';
import 'package:travel_ticket_app/screens/voyageur/voyageur-dashboard.dart';
import 'package:travel_ticket_app/screens/compagnie/compagnie-dashboard.dart';
import 'package:travel_ticket_app/screens/administrateur/admin-dashboard.dart';

class BottomNavBar extends StatelessWidget {
  final String roleId; // Le rôle de l'utilisateur (1 = Voyageur, 2 = Compagnie, 3 = Administrateur)

  const BottomNavBar({super.key, required this.roleId});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Container(
        height: 60,
        decoration: const BoxDecoration(
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
            // Icône Home : Actualise la page actuelle
            IconButton(
              icon: const Icon(Icons.home_outlined, size: 28),
              color: Colors.blue,
              onPressed: () {
                Widget destination;
                switch (roleId) {
                  case '1':
                    destination = VoyageurDashboard();
                    break;
                  case '2':
                    destination = CompagnieDashboard();
                    break;
                  case '3':
                    destination = AdminDashboard();
                    break;
                  default:
                    return;
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => destination),
                );
              },
            ),
            // Icône Paramètres
            IconButton(
              icon: const Icon(Icons.settings_outlined, size: 28),
              color: Colors.grey,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
