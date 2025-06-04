import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_ticket_app/models/voyageur.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Ajout d'un voyage dans Firestore
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
      rethrow;
    }
  }

  /// Récupérer les voyages d'un utilisateur
  Future<List<Map<String, dynamic>>> getVoyages(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('voyages')
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Récupérer les informations d'un utilisateur
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('utilisateurs').doc(userId).get();
      return doc.exists ? doc.data() as Map<String, dynamic> : null;
    } catch (e) {
      rethrow;
    }
  }

  /// Mettre à jour un utilisateur
  Future<void> updateUser(String userId, String nom, String email, String roleId) async {
    try {
      await _firestore.collection('utilisateurs').doc(userId).update({
        'nom': nom,
        'email': email,
        'role_id': roleId,
        'date_modification': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Supprimer un voyage
  Future<void> deleteVoyage(String voyageId) async {
    try {
      await _firestore.collection('voyages').doc(voyageId).delete();
    } catch (e) {
      rethrow;
    }
  }

  /// Ajouter un voyageur lié à un utilisateur
Future<void> addVoyageur({
  required String userId,
  required String nom,
  required String email,
  required String telephone,
  required String dateNaissance,
  required String adresse,
  required String photoProfil,
  required List<String> reservationsIds, // Liste des réservations à associer
}) async {
  try {
    // Vérifier si l'utilisateur est déjà un voyageur
    DocumentSnapshot doc = await _firestore.collection('voyageur').doc(userId).get();
    if (doc.exists) {
      throw Exception("Cet utilisateur est déjà un voyageur.");
    }

    // Ajouter un voyageur avec userId comme clé unique
    await _firestore.collection('voyageur').doc(userId).set({
      'userId': userId,
      'nom': nom,
      'email': email,
      'telephone': telephone,
      'date_naissance': dateNaissance,
      'adresse': adresse,
      'statut': 'actif', // Par défaut, actif
      'nombre_reservations': 0,
      'moyenne_depenses': 0,
      'programme_fidelite': {
        'points': 0,
        'niveau': 'Bronze',
      },
      'photo_profil': photoProfil,
      'date_inscription': DateTime.now().toIso8601String(),
      'reservations_ids': reservationsIds, // Ajout des réservations
    });

    // Mettre à jour l'utilisateur pour lui attribuer le rôle "voyageur"
    await _firestore.collection('users').doc(userId).update({'role': "voyageur"});

    print('Voyageur ajouté avec succès !');
  } catch (e) {
    print('Erreur lors de l\'ajout du voyageur : $e');
    rethrow;
  }
}

  /// Ajouter une compagnie liée à un utilisateur
  Future<void> addCompagnie({
    required String userId,
    required String nom,
    required String email,
    required String telephone,
    required String siegeSocial,
    required String logo,
  }) async {
    try {
      // Vérifier si l'utilisateur est déjà une compagnie
      QuerySnapshot query = await _firestore
          .collection('compagnie')
          .where('userId', isEqualTo: userId)
          .get();

      if (query.docs.isNotEmpty) {
        throw Exception("Cet utilisateur est déjà une compagnie.");
      }

      DocumentReference docRef = await _firestore.collection('compagnie').add({
        'userId': userId,
        'nom': nom,
        'email': email,
        'telephone': telephone,
        'siege_social': siegeSocial,
        'statut': 'actif',
        'nombre_bus': 0,
        'nombre_reservations': 0,
        'nombre_voyages': 0,
        'note_moyenne': 0.0,
        'logo': logo,
        'date_inscription': DateTime.now().toIso8601String(),
      });

      // Mettre à jour l'utilisateur pour lui attribuer un rôle "compagnie"
      await updateUser(userId, nom, email, "3"); // 3 = rôle Compagnie
    } catch (e) {
      rethrow;
    }
  }

// Fonction pour récupérer les détails du voyageur depuis la réservation
Future<VoyageurModel> getVoyageurFromReservation(String reservationId) async {
  DocumentSnapshot reservationDoc = await _firestore.collection('reservations').doc(reservationId).get();
  String voyageurId = reservationDoc['voyageur_id'];

  DocumentSnapshot voyageurDoc = await _firestore.collection('voyageur').doc(voyageurId).get();

  return VoyageurModel.fromFirestore(voyageurDoc);
}





}
