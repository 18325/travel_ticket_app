import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_ticket_app/widgets/HeaderFlottant.dart';
import 'package:travel_ticket_app/widgets/bottom_nav_bar.dart';
import 'package:travel_ticket_app/screens/administrateur/liste_reservations_page.dart';
import 'package:travel_ticket_app/screens/administrateur/ajouter_voyageur_page.dart'; // Importez la page Ajouter Voyageur

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String? roleId;

  @override
  void initState() {
    super.initState();
    _getUserRole();
  }

  Future<void> _getUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('utilisateurs')
          .doc(user.uid)
          .get();
      setState(() {
        roleId = userDoc['role_id'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade600, Colors.orange.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: Text(
                    "Espace de Gestion",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(2.0, 2.0),
                          blurRadius: 8.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Bouton "Gestion des Utilisateurs"
              _buildElevatedButton(
                context,
                '/vue_utilisateurs',
                'Gestion des Utilisateurs',
                Icons.people,
              ),

              // Bouton "Auditer les réservations"
              _buildElevatedButton(
                  context,
                  '/liste_reservations', // Route pour la liste des réservations
                  'Auditer les réservations',
                  Icons.pending_actions, // Corrected icon
                ),

              // Bouton "Ajouter Voyageur"
              _buildElevatedButton(
                context,
                '/ajouter_voyageur', // Nouvelle route pour ajouter un voyageur
                'Ajouter Voyageur',
                Icons.person,
              ),

            ],
          ),
          if (roleId != null) HeaderFlottant(roleId: roleId!),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/ajouter_compagnie');
        },
        label: Text(
          'Ajouter Compagnie',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        icon: Icon(Icons.add_business_rounded, size: 28),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 8.0,
      ),
      bottomNavigationBar: roleId != null ? BottomNavBar(roleId: roleId!) : null,
    );
  }

  // Fonction pour créer les boutons de manière plus concise
  Widget _buildElevatedButton(BuildContext context, String route, String label, IconData icon) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15),
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, route);
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 60),
            backgroundColor: Colors.orange.shade800,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            shadowColor: Colors.orangeAccent,
            elevation: 20,
          ),
          icon: Icon(icon, size: 28, color: Colors.white),
          label: Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
        ),
      ),
    );
  }
}
