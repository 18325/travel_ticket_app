import 'package:flutter/material.dart';
import 'package:travel_ticket_app/widgets/HeaderFlottant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_ticket_app/widgets/bottom_nav_bar.dart';

class VoyageurDashboard extends StatefulWidget {
  @override
  _VoyageurDashboardState createState() => _VoyageurDashboardState();
}

class _VoyageurDashboardState extends State<VoyageurDashboard> {
  String? roleId;

  @override
  void initState() {
    super.initState();
    _getUserRole();
  }

  // Récupérer le rôle de l'utilisateur depuis Firebase
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
     
      body: Stack(
        children: [
          // Contenu principal de la page
          Center(
            child: roleId == null
                ? CircularProgressIndicator() // Afficher un loader si le rôle n'est pas encore chargé
                : Text(
                    'Bienvenue sur le tableau de bord pour le rôle : $roleId',
                    style: TextStyle(fontSize: 18),
                  ),
          ),

          // Afficher le HeaderFlottant si le rôle est défini
          if (roleId != null) HeaderFlottant(roleId: roleId!),
        ],
      ),

      // Barre de navigation inférieure
      bottomNavigationBar: roleId != null
          ? BottomNavBar(roleId: roleId!) // Afficher la barre si le rôle est défini
          : null, // Pas de barre tant que le rôle n'est pas chargé
    );
  }
}
