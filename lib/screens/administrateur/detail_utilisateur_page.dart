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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Profil Utilisateur'),
        backgroundColor: Colors.black87,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.redAccent),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image de couverture avec avatar amélioré
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/buss.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -60,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage('assets/default_avatar.png'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 70),

            // Carte des informations utilisateur avec une meilleure mise en page
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 6,
                shadowColor: Colors.black54,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        user['nom'] ?? 'Nom non renseigné',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Chip(
                        label: Text(
                          role,
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: roleColor,
                      ),
                      Divider(height: 30, thickness: 1.5, color: Colors.black26),
                      if (user['email'] != null) _buildInfoTile(Icons.email, "Email", user['email']),
                      // if (user['telephone'] != null) _buildInfoTile(Icons.phone, "Téléphone", user['telephone']),
                      // Ajouter un champ d'adresse seulement si l'adresse existe
                      // if (user['adresse'] != null) _buildInfoTile(Icons.location_on, "Adresse", user['adresse']),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),

            // Bouton de suppression plus attrayant
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
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Widget pour afficher une ligne d'information utilisateur avec une meilleure présentation
  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey, size: 28),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Fonction pour confirmer et effectuer la suppression d’un utilisateur
  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
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
                  await FirebaseFirestore.instance
                      .collection('utilisateurs') // Nom de la collection
                      .doc(user.id) // Supprime l'utilisateur par son ID
                      .delete();

                  Navigator.of(context).pop(); // Ferme la boîte de dialogue
                  Navigator.of(context).pop(); // Retourne à la page précédente

                  // Affiche une notification
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Utilisateur supprimé avec succès."),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Erreur lors de la suppression : $e"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}
