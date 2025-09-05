// CÓDIGO ATUALIZADO para: lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phato_mvp/screens/home_screen.dart';
import 'package:phato_mvp/services/auth_service.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) { // 'ref' já está disponível aqui
    final authService = ref.read(authServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Phato - Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Adicionado para evitar overflow em telas pequenas
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ... Campos de Email e Senha (sem alterações) ...
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Senha', border: OutlineInputBorder()),
                obscureText: true,
              ),
              const SizedBox(height: 24.0),
              // Botão de LOGIN (sem alterações)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  ),
                  onPressed: () async {
                    try {
                      await authService.signInWithEmailAndPassword(_emailController.text, _passwordController.text);
                      if (context.mounted) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen()));
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao fazer login: ${e.toString().split('] ').last}')));
                      }
                    }
                  },
                  child: Text('LOGIN', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 24.0),
              // Divisor "OU" (sem alterações)
              Row(
                children: [
                  Expanded(child: Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('OU', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8))),
                  ),
                  Expanded(child: Divider(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))),
                ],
              ),
              const SizedBox(height: 24.0),
              // Botão Google Sign-In
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15), side: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), width: 1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), foregroundColor: Theme.of(context).colorScheme.onSurface),
                  onPressed: () async {
                    try {
                      // MUDANÇA AQUI: Usando 'ref' diretamente, que é mais limpo.
                      await ref.read(authServiceProvider).signInWithGoogle();
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao fazer login com Google: $e')));
                      }
                    }
                  },
                  icon: Image.asset(
                    'assets/google_logo.png', // MUDANÇA AQUI: Caminho corrigido
                    height: 16,
                  ),
                  label: Text('Sign-In with Google', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16.0),
              // Botão Apple Sign-In (sem alterações)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15), side: BorderSide(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5), width: 1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), foregroundColor: Theme.of(context).colorScheme.onSurface),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login com Apple (mock)!')));
                  },
                  icon: Icon(Icons.apple, color: Theme.of(context).colorScheme.onSurface),
                  label: Text('Sign-In with Apple', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                ),
              ),
              // ... resto do código sem alterações ...
            ],
          ),
        ),
      ),
    );
  }
}