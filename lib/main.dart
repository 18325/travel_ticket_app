import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Nécessaire pour utiliser Firebase
  await Firebase.initializeApp(); // Initialisation de Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Firebase Firestore',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const FirestoreTestPage(),
    );
  }
}

class FirestoreTestPage extends StatelessWidget {
  const FirestoreTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Référence à la collection 'voyages' dans Firestore
    final CollectionReference voyages =
    FirebaseFirestore.instance.collection('voyages');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Récupération des données Firestore'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: voyages.get(), // Récupère les données de la collection
        builder: (context, snapshot) {
          // Vérifie l'état de la connexion
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Vérifie s'il y a une erreur
          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }

          // Vérifie si les données sont disponibles
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Aucune donnée trouvée.'));
          }

          // Récupère la liste des documents
          final List<DocumentSnapshot> docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              // Récupère les données d'un document
              final Map<String, dynamic> data =
              docs[index].data() as Map<String, dynamic>;

              return Card(
                child: ListTile(
                  title: Text(data['destination'] ?? 'Destination inconnue'),
                  subtitle: Text('Prix : ${data['prix'] ?? 'Non défini'} €'),
                  trailing: Icon(Icons.airplane_ticket, color: Colors.blue),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
