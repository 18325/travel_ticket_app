import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_ticket_app/widgets/bottom_nav_bar.dart';

class CompagnieDashboard extends StatefulWidget {
  const CompagnieDashboard({super.key});

  @override
  _CompagnieDashboardState createState() => _CompagnieDashboardState();
}

class _CompagnieDashboardState extends State<CompagnieDashboard> {
  String? roleId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserRole();
  }

  Future<void> _getUserRole() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('utilisateurs')
            .doc(user.uid)
            .get();
        if (mounted) {
          setState(() {
            roleId = userDoc['role_id'] ?? 'inconnu';
            isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      print("Erreur lors de la récupération du rôle : $e");
    }
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Tableau de bord",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade700,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade400, Colors.indigo.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.directions_bus, size: 100, color: Colors.white),
                  const SizedBox(height: 20),
                  const Text(
                    "Bienvenue sur votre espace Compagnie",
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildDashboardCard(
                        icon: Icons.add,
                        title: "Ajouter un Voyage",
                        onTap: () => Navigator.pushNamed(context, '/ajouter_voyage'),
                        color: Colors.orange.shade600,
                      ),
                      _buildDashboardCard(
                        icon: Icons.list,
                        title: "Liste des Voyages",
                        onTap: () => Navigator.pushNamed(context, '/liste_voyages'),
                        color: Colors.blue.shade600,
                      ),
                      _buildDashboardCard(
                        icon: Icons.receipt_long,
                        title: "Voir Réservations",
                        onTap: () => Navigator.pushNamed(context, '/liste_reservations'),
                        color: Colors.purple.shade600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
      bottomNavigationBar: roleId != null ? BottomNavBar(roleId: roleId!) : null,
    );
  }

  Widget _buildDashboardCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), color.withOpacity(1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.5), blurRadius: 10, offset: const Offset(4, 4)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
