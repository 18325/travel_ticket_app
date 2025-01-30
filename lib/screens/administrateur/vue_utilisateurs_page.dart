import 'package:firebase_auth/firebase_auth.dart';
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
        title: Text('Liste des Utilisateurs'),
        backgroundColor: Colors.blueAccent,
        elevation: 6.0,
        shadowColor: Colors.black.withOpacity(0.1),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: TextField(
                controller: _searchController,
                style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                decoration: InputDecoration(
                  hintText: 'Rechercher par nom ou email',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.grey[500]),
                  prefixIcon: Icon(Icons.search, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.blue[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<DocumentSnapshot>>(
                future: _getUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        "Aucun utilisateur trouvé.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  List<DocumentSnapshot> usersToShow =
                      _searchText.isNotEmpty ? _filteredUsers : snapshot.data!;

                  return ListView.builder(
                    itemCount: usersToShow.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot user = usersToShow[index];
                      String role = user['role_id'] == '1' ? 'Voyageur' : 'Compagnie';

                      Color roleColor = role == 'Voyageur' ? Colors.blue : Colors.green;

                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/detail_utilisateur',
                            arguments: user, // Passer les données de l'utilisateur
                          );
                        },

                        child: Card(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadowColor: Colors.black.withOpacity(0.1),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            leading: CircleAvatar(
                              backgroundColor: roleColor,
                              radius: 30,
                              child: user['nom'] != null
                                  ? Text(
                                      user['nom'][0].toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    )
                                  : Container(),
                            ),
                            title: Text(
                              user['nom'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
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
                          ),
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
