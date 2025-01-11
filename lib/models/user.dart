class UserModel {
  final String id;
  final String nom;
  final String email;
  final String roleId;

  UserModel({
    required this.id,
    required this.nom,
    required this.email,
    required this.roleId,
  });

  // Conversion Firebase Document -> UserModel
  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      nom: data['nom'] ?? '',
      email: data['email'] ?? '',
      roleId: data['role_id'] ?? '',
    );
  }

  // Conversion UserModel -> Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'email': email,
      'role_id': roleId,
    };
  }
}
