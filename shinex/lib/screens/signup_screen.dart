import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final void Function(String, String) onSignUp;
  final VoidCallback onSwitchToLogin;
  final bool isLoading;

  SignUpScreen({
    super.key,
    required this.onSignUp,
    required this.onSwitchToLogin,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () => onSignUp(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      ),
                      child: const Text('Sign Up'),
                    ),
              TextButton(
                onPressed: onSwitchToLogin,
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
