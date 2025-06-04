import 'package:cloud_firestore/cloud_firestore.dart';

class VoyageurModel {
  final String id; // ID du document Firestore
  final String userId; // Lien avec l'utilisateur
  final String nom;
  final String email;
  final String telephone;
  final String adresse;
  final List<String> reservationsIds; // Liste des IDs de réservations associées

  VoyageurModel({
    required this.id,
    required this.userId,
    required this.nom,
    required this.email,
    required this.telephone,
    required this.adresse,
    required this.reservationsIds,
  });

  // 🔄 Convertir un document Firestore en objet VoyageurModel
  factory VoyageurModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return VoyageurModel(
      id: doc.id,
      userId: data['user_id'] ?? '',
      nom: data['nom'] ?? '',
      email: data['email'] ?? '',
      telephone: data['telephone'] ?? '',
      adresse: data['adresse'] ?? '',
      reservationsIds: List<String>.from(data['reservations_ids'] ?? []),
    );
  }

  // 🔄 Convertir un objet VoyageurModel en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'user_id': userId,
      'nom': nom,
      'email': email,
      'telephone': telephone,
      'adresse': adresse,
      'reservations_ids': reservationsIds,
    };
  }
}
