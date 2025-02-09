import 'package:flutter/material.dart';
import 'package:travel_ticket_app/screens/administrateur/liste_reservations_page.dart';
import 'package:travel_ticket_app/screens/voyageur/search_voyages_screen.dart';
import 'package:travel_ticket_app/widgets/HeaderFlottant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_ticket_app/widgets/bottom_nav_bar.dart';

class VoyageurDashboard extends StatefulWidget {
  const VoyageurDashboard({super.key});

  @override
  _VoyageurDashboardState createState() => _VoyageurDashboardState();
}

class _VoyageurDashboardState extends State<VoyageurDashboard> {
  String? roleId;
  bool _isLoading = true;

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
      if (mounted) { // Check if the widget is still mounted
        setState(() {
          roleId = userDoc['role_id'];
          _isLoading = false; // Data loaded, set loading to false
        });
      }
    } else {
        if (mounted) {
          setState(() => _isLoading = false); // Handle the case where the user is null
        }
    }

  }

  Widget _buildIconTile(IconData icon, String label, Color textColor, Color tileColor, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: tileColor,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: textColor),
            const SizedBox(height: 10),
            Text(label, style: TextStyle(color: textColor, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade300, Colors.green.shade200], // Example gradient
              ),
            ),
          ),

          if (_isLoading)  // Show loading indicator while fetching data
            const Center(child: CircularProgressIndicator())
          else if (roleId != null)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1,
                  ),
                  shrinkWrap: true,
                  children: [
                    _buildIconTile(
                      Icons.search, 
                      'Rechercher un voyage',
                      Colors.white,
                      Colors.blue.shade700, // Darker blue for the tile
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchVoyagesScreen(),
                          ),
                        );
                      },
                    ),
                    _buildIconTile(
                      Icons.calendar_today,
                      'Mes Réservations',
                      Colors.white,
                      Colors.green.shade600, // Darker green for the tile
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListeReservationsPage(),
                          ),
                        );
                      },
                    ),
                    _buildIconTile(
                      Icons.report,
                      'Faire un signalement',
                      Colors.white,
                      Colors.red.shade700, // Darker red for the tile
                      () {
                        Navigator.pushNamed(context, '/signalement');
                      },
                    ),
                    _buildIconTile(Icons.settings, 'Paramètres', Colors.white, Colors.grey.shade800, () {

                      Navigator.pushNamed(context, '/settings');
                    }),
                  ],
                ),
              ),
            )
          // The 'else' here handles cases where roleId is still null after loading
          else const Center(child: Text("No role assigned")),
          if (roleId != null)
            HeaderFlottant(roleId: roleId!),
        ],
      ),
      bottomNavigationBar: roleId != null ? BottomNavBar(roleId: roleId!) : null,
    );
  }




  // ... (rest of the code)
}
