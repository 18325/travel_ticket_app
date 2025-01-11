import 'package:flutter/material.dart';
import 'package:travel_ticket_app/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String _selectedRole = UserRole.voyageur;
  final AuthService _authService = AuthService();

  bool _isLoading = false;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _authService.registerUser(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _nameController.text.trim(),
          _selectedRole,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inscription réussie !')),
        );
        Navigator.pushReplacementNamed(context, '/login');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo ou Illustration
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'), // Remplacez par votre logo
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Titre
                const Text(
                  'Créer un compte',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E88E5),
                  ),
                ),
                const SizedBox(height: 16),
                // Formulaire
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _nameController,
                        label: 'Nom',
                        icon: Icons.person,
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Veuillez entrer votre nom' : null,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _emailController,
                        label: 'E-mail',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Veuillez entrer votre e-mail' : null,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _passwordController,
                        label: 'Mot de passe',
                        icon: Icons.lock,
                        obscureText: true,
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Veuillez entrer un mot de passe' : null,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _selectedRole,
                        decoration: InputDecoration(
                          labelText: 'Type d\'utilisateur',
                          prefixIcon: const Icon(Icons.group),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: UserRole.voyageur,
                            child: Text('Voyageur'),
                          ),
                          DropdownMenuItem(
                            value: UserRole.compagnie,
                            child: Text('Compagnie'),
                          ),
                          DropdownMenuItem(
                            value: UserRole.administrateur,
                            child: Text('Administrateur'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedRole = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Bouton d'inscription
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E88E5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          'S\'inscrire',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                const SizedBox(height: 16),
                // Lien vers la page de connexion
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text(
                    'Déjà inscrit ? Connectez-vous',
                    style: TextStyle(color: Color(0xFF1E88E5)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Méthode pour construire un champ de texte personnalisé
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF1E88E5)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: validator,
    );
  }
}
