

```markdown
# 🚀 Travel Ticket App — Architecture de base

## ⚙️ Avant de commencer

1. **Téléchargez Gradle 8.2.0**  
   👉 [Lien officiel Gradle 8.2.0](https://gradle.org/releases/)

2. **Placez-le ici** *(pour les utilisateurs Windows)* :  
```

C:\Users<nom_utilisateur>\gradle\wrapper\dists

```

3. **Modifiez le fichier suivant :**  
```

<votre_projet>\travel_ticket_app\android\gradle\wrapper\gradle-wrapper.properties

```

4. **Remplacez la dernière ligne par :**  
```

distributionUrl=file:///C:/Users/<nom_utilisateur>/.gradle/wrapper/dists/gradle-8.2-all.zip

```

---

## 🗂️ Structure du projet Flutter

```

lib/
├── models/
│   ├── user.dart
│   └── voyage.dart
│
├── services/
│   ├── auth_service.dart
│   └── firebase_service.dart
│
├── screens/
│   ├── auth/
│   │   ├── login_page.dart
│   │   └── inscription_page.dart
│   │
│   ├── splash_screen.dart         // Écran de chargement (ne pas modifier)
│   ├── welcome_page.dart          // Choix : Voyageur ou Compagnie
│   │
│   ├── voyageur/
│   ├── compagnie/
│   └── administrateur/
│
├── widgets/
│   ├── custom_button.dart
│   └── custom_logo.dart
│
├── utils/
│   └── constants.dart
│
└── main.dart

````

---

## 🧩 Base de données Firestore

### 1️⃣ **Collection : roles**

| id | nom           |
|----|----------------|
| 1  | Voyageur       |
| 2  | Compagnie      |
| 3  | Administrateur |

---

### 2️⃣ **Collection : utilisateurs**

#### 📄 Document 1 (Voyageur)
```json
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
````

#### 📄 Document 2 (Compagnie)

```json
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
```

---

### 3️⃣ **Collection : notifications**

```json
{
  "id": "1",
  "utilisateur_id": "1",
  "contenu": "Votre réservation a été confirmée.",
  "date_envoi": "2025-01-07",
  "est_lu": false
}
```

---

### 4️⃣ **Collection : voyages**

```json
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
```

---

### 5️⃣ **Collection : reservations**

```json
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
```

---

### 6️⃣ **Collection : paiements**

```json
{
  "id": "1",
  "reservation_id": "1",
  "montant": 200,
  "date_paiement": "2025-01-07",
  "statut": "payé"
}
```

---

### 7️⃣ **Collection : favoris**

```json
{
  "id": "1",
  "voyageur_id": "1",
  "voyage_id": "1"
}
```

---

### 8️⃣ **Collection : statistiques**

```json
{
  "id": "1",
  "compagnie_id": "2",
  "nombre_reservations": 100,
  "date_mensuelle": "2025-01"
}
```

---

## 🧱 Résumé

Cette architecture offre :

* Une **base Flutter claire et modulaire**
* Une **structure Firestore complète** pour gérer les rôles, utilisateurs, voyages et paiements
* Une **compatibilité assurée** avec **Gradle 8.2.0** pour Android

---

✨ *Projet Travel Ticket App — Système de gestion de voyages et de réservations multi-rôles (Voyageur, Compagnie, Administrateur).*

```


