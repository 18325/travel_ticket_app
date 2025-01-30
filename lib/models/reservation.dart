import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationModel {
  final String codeTicket;
  final Timestamp dateReservation;
  final int id;
  final int prixTotal;
  final int voyageId;
  final int voyageurId;

  ReservationModel({
    required this.codeTicket,
    required this.dateReservation,
    required this.id,
    required this.prixTotal,
    required this.voyageId,
    required this.voyageurId,
  });

  // 🔄 Convertir un document Firestore en objet ReservationModel
  factory ReservationModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return ReservationModel(
      codeTicket: data['code_ticket'] ?? '',
      dateReservation: data['date_reservation'] ?? Timestamp.now(),
      id: data['id'] ?? 0,
      prixTotal: data['prix_total'] ?? 0,
      voyageId: data['voyage_id'] ?? 0,
      voyageurId: data['voyageur_id'] ?? 0,
    );
  }

  // 🔄 Convertir un objet ReservationModel en Map pour Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'code_ticket': codeTicket,
      'date_reservation': dateReservation,
      'id': id,
      'prix_total': prixTotal,
      'voyage_id': voyageId,
      'voyageur_id': voyageurId,
    };
  }
}
