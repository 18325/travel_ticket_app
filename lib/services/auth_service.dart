import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Classe pour gérer les rôles des utilisateurs
class UserRole {
  static const String voyageur = "1";
  static const String compagnie = "2";
  static const String administrateur = "3";
}

/// Service d'authentification
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Inscription d'un utilisateur avec Firebase Auth et Firestore
  Future<User?> registerUser(
      String email, String password, String nom, String roleId) async {
    try {
      // Création de l'utilisateur dans Firebase Auth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Ajout des détails de l'utilisateur dans Firestore
      await _firestore
          .collection('utilisateurs')
          .doc(userCredential.user!.uid)
          .set({
        'id': userCredential.user!.uid,
        'nom': nom,
        'email': email,
        'role_id': roleId,
        'date_inscription': DateTime.now().toIso8601String(),
      });

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception('Cet e-mail est déjà utilisé.');
      } else if (e.code == 'weak-password') {
        throw Exception('Le mot de passe est trop faible.');
      } else {
        throw Exception('Erreur lors de l\'inscription : ${e.message}');
      }
    } catch (e) {
      throw Exception('Une erreur inattendue s\'est produite : $e');
    }
  }

  /// Connexion d'un utilisateur avec redirection basée sur le rôle
  Future<void> loginUser(BuildContext context, String email, String password) async {
    try {
      // Déconnexion avant de tenter une nouvelle connexion
      await _auth.signOut();

      // Connexion via Firebase Auth
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Récupération des informations de l'utilisateur depuis Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection('utilisateurs')
          .doc(userCredential.user!.uid)
          .get();
      String roleId = userDoc['role_id'];

      // Redirection basée sur le rôle
      if (roleId == UserRole.voyageur) {
        Navigator.pushReplacementNamed(context, '/voyageur_dashboard');
      } else if (roleId == UserRole.compagnie) {
        Navigator.pushReplacementNamed(context, '/compagnie_dashboard');
      } else if (roleId == UserRole.administrateur) {
        Navigator.pushReplacementNamed(context, '/admin_dashboard');
      } else {
        throw Exception("Rôle non défini pour cet utilisateur.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('Aucun utilisateur trouvé pour cet e-mail.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Le mot de passe est incorrect.');
      } else if (e.code == 'expired-action-code') {
        throw Exception('Le code d\'action a expiré.');
      } else if (e.code == 'invalid-credential') {
        throw Exception('Les informations d\'identification sont mal formatées.');
      } else {
        throw Exception('Erreur lors de la connexion : ${e.message}');
      }
    } catch (e) {
      throw Exception('Une erreur inattendue s\'est produite : $e');
    }
  }

  /// Déconnexion de l'utilisateur
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Erreur lors de la déconnexion : $e');
    }
  }

  /// Vérifie si un utilisateur est connecté
  User? get currentUser => _auth.currentUser;

  /// Récupère le rôle de l'utilisateur connecté
  Future<String> getUserRole() async {
    if (currentUser != null) {
      DocumentSnapshot userDoc = await _firestore
          .collection('utilisateurs')
          .doc(currentUser!.uid)
          .get();
      return userDoc['role_id'] ?? '0'; // Retourne '0' si aucun rôle trouvé
    } else {
      throw Exception('Aucun utilisateur connecté.');
    }
  }

 
  // AuthService.dart

/// Réinitialisation du mot de passe de l'utilisateur
Future<void> passwordForgot(String email) async {
  try {
    await _auth.sendPasswordResetEmail(email: email);
  } catch (e) {
    throw Exception('Erreur lors de l\'envoi de l\'e-mail de réinitialisation : $e');
  }
}


  /// Rediriger l'utilisateur en fonction de son rôle
  Future<void> redirectBasedOnRole(BuildContext context) async {
    try {
      if (currentUser != null) {
        DocumentSnapshot userDoc = await _firestore
            .collection('utilisateurs')
            .doc(currentUser!.uid)
            .get();
        String roleId = userDoc['role_id'];

        // Redirection
        if (roleId == UserRole.voyageur) {
          Navigator.pushReplacementNamed(context, '/voyageur-dashboard');
        } else if (roleId == UserRole.compagnie) {
          Navigator.pushReplacementNamed(context, '/compagnie-dashboard');
        } else if (roleId == UserRole.administrateur) {
          Navigator.pushReplacementNamed(context, '/admin-dashboard');
        } else {
          throw Exception("Rôle non défini pour cet utilisateur.");
        }
      } else {
        throw Exception('Utilisateur non connecté.');
      }
    } catch (e) {
      throw Exception('Erreur lors de la redirection : $e');
    }
  }
}
