class CompagnieModel {
  final String id;
  final String utilisateurId;
  final String siegeSocial;
  final String telephone;
  final String statut;

  CompagnieModel({
    required this.id,
    required this.utilisateurId,
    required this.siegeSocial,
    required this.telephone,
    required this.statut,
  });

  factory CompagnieModel.fromMap(Map<String, dynamic> data, String documentId) {
    return CompagnieModel(
      id: documentId,
      utilisateurId: data['utilisateur_id'] ?? '',
      siegeSocial: data['siege_social'] ?? '',
      telephone: data['telephone'] ?? '',
      statut: data['statut'] ?? 'actif',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'utilisateur_id': utilisateurId,
      'siege_social': siegeSocial,
      'telephone': telephone,
      'statut': statut,
    };
  }
}
