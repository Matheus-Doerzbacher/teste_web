import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_web/modules/auth/presentation/controllers/auth_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      drawer: const Drawer(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(controller.usuario?.name ?? 'Não foi encontrado o usuario'),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                controller.loadUserData();
              },
              child: const Text('Buscar Usuario'),
            ),
            const SizedBox(height: 24),
            FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error),
              onPressed: () {
                controller.clearUserData();
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: const Text('Logout'),
            ),
            const SizedBox(height: 24),
            Text(controller.isAuthenticated.toString()),
            const SizedBox(height: 24),
            FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.tertiary),
              onPressed: () {},
              child: const Text('Graficos'),
            ),
          ],
        ),
      ),
    );
  }
}
