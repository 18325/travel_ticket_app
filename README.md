# Travel Ticket App 🚌🚂

Une application mobile moderne de réservation de tickets de voyage (bus et train) développée avec Flutter et Firebase.

## 📋 Description

Travel Ticket App est une application mobile cross-platform qui permet aux utilisateurs de rechercher, réserver et gérer leurs tickets de voyage pour les transports en commun (bus et trains). L'application offre une interface intuitive et une expérience utilisateur optimale pour faciliter les déplacements au quotidien.

## ✨ Fonctionnalités principales

### Pour les voyageurs
- 🔍 **Recherche de trajets** : Trouvez facilement les itinéraires disponibles
- 🎫 **Réservation de tickets** : Réservez vos places en quelques clics
- 📅 **Gestion des réservations** : Consultez et gérez vos tickets actuels et passés
- 💳 **Paiement sécurisé** : Payez en toute sécurité vos réservations
- 🔔 **Notifications** : Recevez des alertes pour vos voyages à venir
- 📍 **Suivi en temps réel** : Suivez votre véhicule en temps réel

### Authentification et profil
- 🔐 **Connexion sécurisée** : Authentification via Firebase Auth
- 👤 **Gestion de profil** : Créez et gérez votre profil utilisateur
- 📊 **Historique** : Consultez l'historique de vos voyages
- ⭐ **Favoris** : Enregistrez vos trajets favoris

### Interface utilisateur
- 🎨 **Design moderne** : Interface élégante et intuitive
- 📱 **Multi-plateforme** : Fonctionne sur Android, iOS, Web, Windows, macOS et Linux
- 🌐 **Responsive** : Adaptée à tous les formats d'écran
- ⚡ **Animations fluides** : Expérience utilisateur agréable avec animated_text_kit et flutter_spinkit

## 🛠️ Technologies utilisées

### Framework et langage
- **Framework** : Flutter 3.6.0+
- **Langage** :  Dart 3.6.0+
- **Architecture** : MVVM / Clean Architecture

### Backend et services
- **Backend as a Service** :  Firebase
- **Authentification** : Firebase Auth 5.4.0
- **Base de données** : Cloud Firestore 5.6.1
- **Cloud** : Firebase Core 3.10.0

### Packages et dépendances
- **Loading animations** : flutter_spinkit 5.2.1
- **Animations de texte** : animated_text_kit 4.2.2
- **Icônes iOS** : cupertino_icons 1.0.8

### Outils de développement
- **Linting** : flutter_lints 5.0.0
- **Tests** : flutter_test (SDK Flutter)
- **Analyse de code** : analysis_options.yaml

## 📋 Prérequis

Avant de commencer, assurez-vous d'avoir installé : 

- **Flutter SDK** >= 3.6.0
- **Dart SDK** >= 3.6.0
- **Android Studio** ou **Xcode** (pour le développement mobile)
- **Un compte Firebase** (gratuit)
- **Git**

## 🚀 Installation

### 1. Cloner le dépôt

```bash
git clone https://github.com/18325/travel_ticket_app.git
cd travel_ticket_app
```

### 2. Installer les dépendances

```bash
flutter pub get
```

### 3. Configuration Firebase

#### a. Créer un projet Firebase

1. Allez sur [Firebase Console](https://console.firebase.google.com/)
2. Créez un nouveau projet
3. Activez **Authentication** (Email/Password)
4. Activez **Cloud Firestore**

#### b. Configurer Android

1. Téléchargez le fichier `google-services.json`
2. Placez-le dans `android/app/`

#### c. Configurer iOS

1. Téléchargez le fichier `GoogleService-Info.plist`
2. Placez-le dans `ios/Runner/`

#### d. Configurer Web

1. Ajoutez la configuration Firebase dans `web/index.html`

### 4. Lancer l'application

```bash
# Android
flutter run -d android

# iOS
flutter run -d ios

# Web
flutter run -d chrome

# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

## 📦 Structure du projet

```
travel_ticket_app/
├── android/              # Configuration Android
├── ios/                  # Configuration iOS
├── web/                  # Configuration Web
├── windows/              # Configuration Windows
├── macos/                # Configuration macOS
├── linux/                # Configuration Linux
├── lib/
│   ├── main.dart        # Point d'entrée de l'application
│   ├── models/          # Modèles de données
│   ├── screens/         # Écrans de l'application
│   ├── widgets/         # Widgets réutilisables
│   ├── services/        # Services (Firebase, API)
│   ├── providers/       # State management
│   └── utils/           # Utilitaires et helpers
├── assets/
│   ├── logo.png         # Logo de l'application
│   └── bus.png          # Icône de bus
├── test/                # Tests unitaires et d'intégration
├── pubspec.yaml         # Dépendances du projet
└── README.md
```

## 💻 Commandes utiles

```bash
# Installer les dépendances
flutter pub get

# Nettoyer le projet
flutter clean

# Vérifier les problèmes
flutter doctor

# Lancer en mode debug
flutter run

# Lancer en mode release
flutter run --release

# Construire pour Android (APK)
flutter build apk

# Construire pour Android (App Bundle)
flutter build appbundle

# Construire pour iOS
flutter build ios

# Construire pour Web
flutter build web

# Lancer les tests
flutter test

# Analyser le code
flutter analyze

# Formater le code
flutter format . 
```

## 🎨 Captures d'écran

*Les captures d'écran seront ajoutées prochainement*

## 🔧 Configuration

### Variables d'environnement

Les configurations Firebase sont gérées via les fichiers : 
- `google-services.json` (Android)
- `GoogleService-Info.plist` (iOS)
- Configuration dans `web/index.html` (Web)

### Personnalisation

Vous pouvez personnaliser l'application en modifiant :
- Les couleurs dans `lib/utils/colors.dart`
- Les thèmes dans `lib/utils/themes.dart`
- Les constantes dans `lib/utils/constants.dart`

## 🚀 Déploiement

### Android

```bash
# Générer un APK de production
flutter build apk --release

# Générer un App Bundle pour Google Play Store
flutter build appbundle --release
```

### iOS

```bash
# Build pour l'App Store
flutter build ios --release

# Ouvrir dans Xcode pour archiver
open ios/Runner.xcworkspace
```

### Web

```bash
# Build pour le web
flutter build web --release

# Déployer sur Firebase Hosting
firebase deploy --only hosting
```

## 🔐 Sécurité

- ✅ Authentification sécurisée avec Firebase Auth
- ✅ Règles de sécurité Firestore configurées
- ✅ Validation des données côté client et serveur
- ✅ Gestion sécurisée des tokens d'authentification
- ✅ HTTPS pour toutes les communications

## 📱 Plateformes supportées

- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 12+)
- ✅ **Web** (Tous les navigateurs modernes)
- ✅ **Windows** (Windows 10+)
- ✅ **macOS** (macOS 10.14+)
- ✅ **Linux**

## 🧪 Tests

```bash
# Lancer tous les tests
flutter test

# Tests avec coverage
flutter test --coverage

# Tests d'intégration
flutter drive --target=test_driver/app.dart
```

## 🐛 Problèmes connus

- Consultez la section [Issues](https://github.com/18325/travel_ticket_app/issues) pour les problèmes en cours

## 🤝 Contribution

Les contributions sont les bienvenues ! Pour contribuer :

1. Forkez le projet
2. Créez une branche (`git checkout -b feature/NouvelleFonctionnalite`)
3. Committez vos changements (`git commit -m 'Ajout d'une nouvelle fonctionnalité'`)
4. Poussez vers la branche (`git push origin feature/NouvelleFonctionnalite`)
5. Ouvrez une Pull Request

## 📄 Licence

Ce projet est sous licence MIT.  Voir le fichier [LICENSE](LICENSE) pour plus de détails. 

## 👤 Auteur

Projet de groupe dont je suis un contributeur **18325**

GitHub:  [@18325](https://github.com/18325)

## 🙏 Remerciements

- Flutter et Dart pour le framework exceptionnel
- Firebase pour les services backend
- La communauté Flutter pour les packages utilisés

## 📞 Support

Pour toute question ou problème : 
- Ouvrez une [issue](https://github.com/18325/travel_ticket_app/issues) sur GitHub
- Consultez la [documentation Flutter](https://flutter.dev/docs)
- Consultez la [documentation Firebase](https://firebase.google.com/docs)

## 🗺️ Roadmap

- [ ] Intégration de paiements en ligne
- [ ] Système de notation et avis
- [ ] Support multilingue
- [ ] Mode hors ligne
- [ ] Notifications push
- [ ] Carte interactive des itinéraires
- [ ] Programme de fidélité
- [ ] Support des QR codes pour les tickets

---

🚌🚂 **Voyagez facilement avec Travel Ticket App ! **
