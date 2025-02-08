import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:travel_ticket_app/models/user.dart';
import 'package:travel_ticket_app/screens/UserProfilePage.dart';
import 'package:travel_ticket_app/screens/administrateur/admin-dashboard.dart';
import 'package:travel_ticket_app/screens/administrateur/ajouter_compagnie_page.dart';
import 'package:travel_ticket_app/screens/administrateur/detail_utilisateur_page.dart';
import 'package:travel_ticket_app/screens/administrateur/liste_reservations_page.dart';
import 'package:travel_ticket_app/screens/administrateur/vue_utilisateurs_page.dart';
import 'package:travel_ticket_app/screens/auth/password_forgot.dart';
import 'package:travel_ticket_app/screens/compagnie/compagnie-dashboard.dart';
import 'package:travel_ticket_app/screens/settings_page.dart';
import 'package:travel_ticket_app/screens/voyageur/voyageur-dashboard.dart';
import 'screens/compagnie/ajouter_voyage_page.dart';
import 'screens/compagnie/liste_voyages_page.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_page.dart';
import 'screens/auth/inscription_page.dart';
import 'screens/welcome_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('fr_FR', null); // 🔥 Initialisation locale

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Ticket App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Définir la route initiale
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/inscription': (context) => const RegisterPage(),
        '/forgot_password': (context) => PasswordForgotPage(),
        '/voyageur_dashboard': (context) => VoyageurDashboard(),
        '/compagnie_dashboard': (context) => CompagnieDashboard(),
        '/admin_dashboard': (context) => AdminDashboard(),
        '/vue_utilisateurs': (context) => VueUtilisateursPage(),
        '/detail_utilisateur': (context) => DetailUtilisateurPage(
              user: ModalRoute.of(context)!.settings.arguments as DocumentSnapshot,
            ),
        '/ajouter_compagnie': (context) => AjouterCompagniePage(),
        '/liste_reservations': (context) => const ListeReservationsPage(),
        '/ajouter_voyage': (context) => AjouterVoyagePage(),
        '/liste_voyages': (context) => ListeVoyagesPage(),
        '/settings': (context) => SettingsPage(),
        '/userprofile': (context) => UserProfilePage(
          user: ModalRoute.of(context)!.settings.arguments as UserModel,
        ), // Nouvelle route ajoutée
      },
    );
  }
}
