import 'package:flutter/material.dart';
import 'package:travel_ticket_app/widgets/HeaderFlottant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_ticket_app/widgets/bottom_nav_bar.dart';

class CompagnieDashboard extends StatefulWidget {
  @override
  _CompagnieDashboardState createState() => _CompagnieDashboardState();
}

class _CompagnieDashboardState extends State<CompagnieDashboard> {
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
          // Ton contenu de page ici
          Center(child: Text("Bienvenue sur le tableau de bord Compagnie")),
          
          // Afficher le HeaderFlottant si le rôle est bien récupéré
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
