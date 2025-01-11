ACHTECTURE BE BASE 

avant de commencer: 
telecharger GRADLE 8.2.0
et mettez le ici dans le dossier : C:\Users\central\gradle\wrapper\dists (pour ceux qui sont sur windows)
ensuite dans : votre projet \travel_ticket_app\android\gradle\wrapper\gradle-wrapper.properties

mettez remplacer la ligne de code , la derniere par : distributionUrl=file:///C:/Users/<nom_utilisateures>/.gradle/wrapper/dists/gradle-8.2-all.zip

vous mettez la ligne de code la: 


lib/
├── models/
│   └── user.dart
│   └── voyage.dart
├── services/
│   └── auth_service.dart
│   └── firebase_service.dart
├── screens/
│   ├── auth/
│   │   └── login_page.dart
│   │   └── inscription_page.dart
|   |__splash_screen.dart ( ceci c'etait pour l'icone de chargement (touche pas) )
|   |__welcome_page.dart  ( ceci c'etait pour le choix Voyageur et Compagnie )
│   ├── voyageur/
│   ├── compagnie/
│   ├── administrateur/
├── widgets/
│   └── custom_button.dart
│   └── custom_logo.dart
├── utils/
│   └── constants.dart
└── main.dart

1. Collection roles
Document 1:

json
Copier le code
{
  "id": "1",
  "nom": "Voyageur"
}
Document 2:

json
Copier le code
{
  "id": "2",
  "nom": "Compagnie"
}
Document 3:

json
Copier le code
{
  "id": "3",
  "nom": "Administrateur"
}
2. Collection utilisateurs
Document 1 (Voyageur) :

json
Copier le code
{
  "id": "1",
  "nom": "Jean Dupont",
  "email": "jean.dupont@example.com",
  "mot_de_passe": "hashed_password",
  "telephone": "0123456789",
  "date_inscription": "2025-01-07",
  "role_id": "1",
  "date_naissance": "1990-01-01",
  "adresse": "10 rue de Paris, France"
}
Document 2 (Compagnie) :

json
Copier le code
{
  "id": "2",
  "nom": "Voyages Express",
  "email": "contact@voyagesexpress.com",
  "mot_de_passe": "hashed_password",
  "telephone": "0987654321",
  "date_inscription": "2025-01-07",
  "role_id": "2",
  "siege_social": "15 avenue des Champs, Paris, France"
}
3. Collection notifications
Document 1 :
json
Copier le code
{
  "id": "1",
  "utilisateur_id": "1",
  "contenu": "Votre réservation a été confirmée.",
  "date_envoi": "2025-01-07",
  "est_lu": false
}
4. Collection voyages
Document 1 :
json
Copier le code
{
  "id": "1",
  "ville_depart": "Paris",
  "ville_arrivee": "Londres",
  "date_depart": "2025-01-15",
  "prix": 100,
  "places_disponibles": 50,
  "type_transport": "bus",
  "compagnie_id": "2"
}
5. Collection reservations
Document 1 :
json
Copier le code
{
  "id": "1",
  "voyageur_id": "1",
  "voyage_id": "1",
  "nombre_places": 2,
  "prix_total": 200,
  "date_reservation": "2025-01-07",
  "statut": "confirmée",
  "code_ticket": "TICKET12345"
}
6. Collection paiements
Document 1 :
json
Copier le code
{
  "id": "1",
  "reservation_id": "1",
  "montant": 200,
  "date_paiement": "2025-01-07",
  "statut": "payé"
}
7. Collection favoris
Document 1 :
json
Copier le code
{
  "id": "1",
  "voyageur_id": "1",
  "voyage_id": "1"
}
8. Collection statistiques
Document 1 :
json
Copier le code
{
  "id": "1",
  "compagnie_id": "2",
  "nombre_reservations": 100,
  "date_mensuelle": "2025-01"
}
