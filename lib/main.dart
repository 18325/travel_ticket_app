import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import pour vérifier l'état de l'utilisateur
import 'package:travel_ticket_app/screens/administrateur/admin-dashboard.dart';
import 'package:travel_ticket_app/screens/auth/password_forgot.dart';
import 'package:travel_ticket_app/screens/compagnie/compagnie-dashboard.dart';
import 'package:travel_ticket_app/screens/voyageur/voyageur-dashboard.dart';
import 'package:travel_ticket_app/services/auth_service.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_page.dart';
import 'screens/auth/inscription_page.dart';
import 'screens/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialisation de Firebase
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
        '/': (context) => const SplashScreen(), // Page de chargement
        '/welcome': (context) => const WelcomePage(), // Page de choix
        '/login': (context) => const LoginPage(), // Page de connexion
        '/inscription': (context) => const RegisterPage(), // Page d'inscription
        '/forgot_password': (context) => PasswordForgotPage(), // route mot de passe oublié
        '/voyageur_dashboard': (context) =>  VoyageurDashboard(),
        '/compagnie_dashboard': (context) =>  CompagnieDashboard(),
        '/admin_dashboard': (context) =>  AdminDashboard(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//   }

  // // Vérifie si l'utilisateur est déjà connecté
  // Future<void> _checkUserLogin() async {
  //   User? user = FirebaseAuth.instance.currentUser;

  //   if (user != null) {
  //     // Si l'utilisateur est connecté, redirige en fonction de son rôle
  //     DocumentSnapshot userDoc = await FirebaseFirestore.instance
  //         .collection('utilisateurs')
  //         .doc(user.uid)
  //         .get();
  //     String roleId = userDoc['role_id'];

  //     if (roleId == UserRole.voyageur) {
  //       Navigator.pushReplacementNamed(context, '/voyageur_dashboard');
  //     } else if (roleId == UserRole.compagnie) {
  //       Navigator.pushReplacementNamed(context, '/compagnie_dashboard');
  //     } else if (roleId == UserRole.administrateur) {
  //       Navigator.pushReplacementNamed(context, '/admin_dashboard');
  //     } else {
  //       // Si rôle inconnu
  //       Navigator.pushReplacementNamed(context, '/login');
  //     }
  //   } else {
  //     // Si l'utilisateur n'est pas connecté, redirige vers la page de login
  //     Navigator.pushReplacementNamed(context, '/login');
  //   }
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(), // Page de chargement pendant la vérification
//       ),
//     );
//   }
// }
