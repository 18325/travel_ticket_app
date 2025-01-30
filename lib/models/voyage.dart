class VoyageModel {
  final String id;
  final String villeDepart;
  final String villeArrivee;
  final String dateDepart;
  final double prix;
  final int placesDisponibles;
  final String typeTransport;
  final String compagnieId;

  VoyageModel({
    required this.id,
    required this.villeDepart,
    required this.villeArrivee,
    required this.dateDepart,
    required this.prix,
    required this.placesDisponibles,
    required this.typeTransport,
    required this.compagnieId,
  });

  factory VoyageModel.fromMap(Map<String, dynamic> data, String documentId) {
    return VoyageModel(
      id: documentId,
      villeDepart: data['ville_depart'] ?? '',
      villeArrivee: data['ville_arrivee'] ?? '',
      dateDepart: data['date_depart'] ?? '',
      prix: (data['prix'] ?? 0).toDouble(),
      placesDisponibles: data['places_disponibles'] ?? 0,
      typeTransport: data['type_transport'] ?? '',
      compagnieId: data['compagnie_id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ville_depart': villeDepart,
      'ville_arrivee': villeArrivee,
      'date_depart': dateDepart,
      'prix': prix,
      'places_disponibles': placesDisponibles,
      'type_transport': typeTransport,
      'compagnie_id': compagnieId,
    };
  }
}
