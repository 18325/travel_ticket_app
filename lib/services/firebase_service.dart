import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Ajout d'un voyage dans Firestore
  Future<void> addVoyage(String userId, String destination, String description, double price) async {
    try {
      await _firestore.collection('voyages').add({
        'userId': userId,
        'destination': destination,
        'description': description,
        'price': price,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw e;
    }
  }

  // Récupérer les voyages d'un utilisateur
  Future<List<Map<String, dynamic>>> getVoyages(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('voyages')
          .where('userId', isEqualTo: userId)
          .get();

      List<Map<String, dynamic>> voyages = [];
      for (var doc in snapshot.docs) {
        voyages.add(doc.data() as Map<String, dynamic>);
      }
      return voyages;
    } catch (e) {
      throw e;
    }
  }

  // Récupérer les utilisateurs de la collection 'utilisateurs'
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('utilisateurs').doc(userId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  // Mettre à jour les informations d'un utilisateur
  Future<void> updateUser(String userId, String nom, String email, String roleId) async {
    try {
      await _firestore.collection('utilisateurs').doc(userId).update({
        'nom': nom,
        'email': email,
        'role_id': roleId,
        'date_modification': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw e;
    }
  }

  // Supprimer un voyage de Firestore
  Future<void> deleteVoyage(String voyageId) async {
    try {
      await _firestore.collection('voyages').doc(voyageId).delete();
    } catch (e) {
      throw e;
    }
  }
}
