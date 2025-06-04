# travel_ticket_app

## Description
Une application Flutter pour la réservation de billets de voyage, probablement pour des bus. Elle prend en charge différents rôles d'utilisateurs tels que voyageur, compagnie et administrateur. Elle utilise Firebase pour les services backend.

## Fonctionnalités
- Authentification des utilisateurs (inscription, connexion, réinitialisation de mot de passe)
- Rôles des utilisateurs : Voyageur, Compagnie, Administrateur
- **Voyageurs :**
    - Rechercher des voyages
    - Réserver des billets
    - Voir les réservations
    - Effectuer des paiements
- **Compagnies :**
    - Gérer les voyages (ajouter, lister)
    - Voir le tableau de bord
- **Administrateurs :**
    - Gérer les utilisateurs (ajouter, voir les détails)
    - Gérer les compagnies (ajouter)
    - Voir toutes les réservations
    - Tableau de bord administrateur

## Démarrage Rapide
Pour commencer avec ce projet :
1. Assurez-vous d'avoir Flutter installé sur votre système. Pour plus d'informations, consultez la [documentation Flutter](https://flutter.dev/docs/get-started/install).
2. Configurez un projet Firebase :
    - Créez un nouveau projet sur la [console Firebase](https://console.firebase.google.com/).
    - Configurez votre application pour Android en ajoutant le fichier `android/app/google-services.json`.
    - Configurez votre application pour iOS (référez-vous à la documentation Firebase pour les étapes spécifiques).
3. Clonez le dépôt :
   ```bash
   git clone <url-du-depot>
   cd travel_ticket_app
   ```
4. Installez les dépendances :
   ```bash
   flutter pub get
   ```
5. Lancez l'application :
   ```bash
   flutter run
   ```

## Dépendances
Ce projet utilise les principales dépendances suivantes (voir `pubspec.yaml` pour la liste complète) :
- `flutter`
- `firebase_core`
- `cloud_firestore`
- `firebase_auth`
- `flutter_spinkit`
- `cupertino_icons`
- `animated_text_kit`
- `intl`
- `font_awesome_flutter`
- `google_fonts`
- `uuid`
- `lottie`

## Contribuer
Les contributions sont les bienvenues ! N'hésitez pas à soumettre une pull request.

## Licence
Ce projet est sous licence MIT.
