import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailUtilisateurPage extends StatelessWidget {
  final DocumentSnapshot user;

  const DetailUtilisateurPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    String role = user['role_id'] == '1' ? 'Voyageur' : 'Compagnie';
    Color roleColor = role == 'Voyageur' ? Colors.blueAccent : Colors.green;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Utilisateur', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black87,
        elevation: 6,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.redAccent),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade400, Colors.green.shade400], // Gradient colors
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                      image: DecorationImage(
                        image: AssetImage('assets/buss.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -60,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: AssetImage('assets/default_avatar.png'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  elevation: 8,
                  color: Colors.white,
                  shadowColor: Colors.black.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Text(
                          user['nom'] ?? 'Nom non renseigné',
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        SizedBox(height: 10),
                        Chip(label: Text(role, style: TextStyle(color: Colors.white, fontSize: 16)), backgroundColor: roleColor),
                        Divider(height: 30, thickness: 1.5, color: Colors.black26),
                        if (user['email'] != null) _buildInfoTile(Icons.email, "Email", user['email']),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton.icon(
                  onPressed: () => _confirmDelete(context),
                  icon: Icon(Icons.delete, color: Colors.white),
                  label: Text("Supprimer Utilisateur", style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey, size: 30),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black54)),
                SizedBox(height: 6),
                Text(value, style: TextStyle(fontSize: 16, color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.redAccent),
              SizedBox(width: 10),
              Text("Supprimer l'utilisateur"),
            ],
          ),
          content: Text(
            "Êtes-vous sûr de vouloir supprimer cet utilisateur ? Cette action est irréversible.",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              child: Text("Annuler", style: TextStyle(color: Colors.black54)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text("Supprimer"),
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance.collection('utilisateurs').doc(user.id).delete();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Utilisateur supprimé avec succès."),
                    backgroundColor: Colors.green,
                  ));
                } catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Erreur lors de la suppression : $e"),
                    backgroundColor: Colors.red,
                  ));
                }
              },
            ),
          ],
        );
      },
    );
  }
}
