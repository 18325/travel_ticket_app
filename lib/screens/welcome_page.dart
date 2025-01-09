import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Espace pour l'image du bus
          Stack(
            children: [
              Container(
                height: 200, // Hauteur réservée pour l'image
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bus.png'), // Changez avec votre image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Superposition pour un effet dégradé
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Icône ou logo
          Hero(
            tag: 'logo',
            child: Image.asset(
              'assets/logo.png', // Chemin de votre logo
              height: 200,
            ),
          ),

          const SizedBox(height: 20),

          // Titre principal
          Text(
            "Bienvenue dans\nTravel Ticket App",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 10),

          // Sous-titre
          Text(
            "Je souhaite m'inscrire en tant que",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 30),

          // Boutons avec animation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Bouton Voyageur
              ElevatedButton(
                onPressed: () {
                  print("Voyageur sélectionné");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadowColor: Colors.blueAccent,
                  elevation: 8,
                  minimumSize: const Size(150, 120),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.person, size: 40, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      'Voyageur',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Bouton Compagnie
              ElevatedButton(
                onPressed: () {
                  print("Compagnie sélectionnée");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadowColor: Colors.orangeAccent,
                  elevation: 8,
                  minimumSize: const Size(150, 120),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.business, size: 40, color: Colors.white),
                    SizedBox(height: 10),
                    Text(
                      'Compagnie',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // Animation légère (texte clignotant ou autre)
          AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(seconds: 2),
            child: const Text(
              "Explorez le futur des voyages dès maintenant",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
