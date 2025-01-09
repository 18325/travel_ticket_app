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
