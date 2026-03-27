import 'package:flutter/material.dart';

import '../core/utils/session_storage.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> _mockLogin(BuildContext context) async {
    await SessionStorage.saveSessionStatus(true);

    if (!context.mounted) {
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _mockLogin(context),
          child: const Text('Entrar'),
        ),
      ),
    );
  }
}
