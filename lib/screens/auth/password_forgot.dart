import 'package:flutter/material.dart';
import 'package:travel_ticket_app/services/auth_service.dart';

class PasswordForgotPage extends StatefulWidget {
  @override
  _PasswordForgotPageState createState() => _PasswordForgotPageState();
}

class _PasswordForgotPageState extends State<PasswordForgotPage> {
  final TextEditingController _emailController = TextEditingController();
  final AuthService _authService = AuthService();
  String _errorMessage = "";

  void _resetPassword() async {
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        _errorMessage = "L'e-mail est requis.";
      });
      return;
    }

    try {
      await _authService.passwordForgot(email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Un e-mail de réinitialisation a été envoyé.')),
      );
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/logo.png', // Assurez-vous que le chemin est correct
                            height: 200,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Mot de passe oublié",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        prefixIcon: Icon(Icons.email, color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (_errorMessage.isNotEmpty)
                      Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _resetPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Réinitialiser le mot de passe",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Retour à la connexion",
                        style: TextStyle(color: Colors.blue.shade700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
