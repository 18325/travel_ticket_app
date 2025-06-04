import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VueUtilisateursPage extends StatefulWidget {
  const VueUtilisateursPage({super.key});

  @override
  _VueUtilisateursPageState createState() => _VueUtilisateursPageState();
}

class _VueUtilisateursPageState extends State<VueUtilisateursPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  List<DocumentSnapshot> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
        _filterUsers();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<DocumentSnapshot>> _getUsers() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('utilisateurs').get();
    return querySnapshot.docs.where((userDoc) => userDoc['role_id'] != '3').toList();
  }

  void _filterUsers() {
    _getUsers().then((users) {
      setState(() {
        _filteredUsers = users.where((user) {
          String name = user['nom'] ?? '';
          String email = user['email'] ?? '';
          return name.toLowerCase().contains(_searchText.toLowerCase()) ||
              email.toLowerCase().contains(_searchText.toLowerCase());
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Retour à la page précédente
          },
        ),
        title: Text(
          'Liste des Utilisateurs',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.white, Colors.orange.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    // Champ de recherche
                    TextField(
                      controller: _searchController,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: 'Rechercher par nom ou email',
                        hintStyle: TextStyle(color: Colors.black54),
                        prefixIcon: Icon(Icons.search, color: Colors.black87),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Liste des utilisateurs
            Expanded(
              child: FutureBuilder<List<DocumentSnapshot>>(
                future: _getUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(color: Colors.black87));
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Erreur : ${snapshot.error}', style: TextStyle(color: Colors.black87)));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        "Aucun utilisateur trouvé.",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    );
                  }

                  List<DocumentSnapshot> usersToShow =
                      _searchText.isNotEmpty ? _filteredUsers : snapshot.data!;

                  return ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: usersToShow.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot user = usersToShow[index];
                      String role = user['role_id'] == '1' ? 'Voyageur' : 'Compagnie';
                      Color roleColor = role == 'Voyageur' ? Colors.blue : Colors.orange;
                      IconData roleIcon = role == 'Voyageur' ? Icons.hiking : Icons.business;

                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16),
                          leading: CircleAvatar(
                            backgroundColor: roleColor,
                            radius: 30,
                            child: Icon(roleIcon, color: Colors.white, size: 30),
                          ),
                          title: Text(
                            user['nom'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            user['email'],
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          ),
                          trailing: Chip(
                            label: Text(
                              role,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: roleColor,
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/detail_utilisateur',
                              arguments: user,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
