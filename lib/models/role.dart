class RoleModel {
  final String id;
  final String nom;

  RoleModel({required this.id, required this.nom});

  factory RoleModel.fromMap(Map<String, dynamic> data, String documentId) {
    return RoleModel(
      id: documentId,
      nom: data['nom'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
    };
  }
}
