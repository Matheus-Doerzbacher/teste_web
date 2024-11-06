import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_web/core/widgets/drawer/drawer_navigation.dart';
import 'package:teste_web/modules/auth/presentation/controllers/auth_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.tryGet<AuthController>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              tooltip: 'Abrir navegação',
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        iconTheme: IconThemeData(color: colorScheme.primary),
        title: Text(
          'Página Principal',
          style: TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
        ),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(),
        ),
      ),
      drawer: const DrawerNavigation(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                AuthController.usuario?.name ?? 'Não foi encontrado o usuario'),
            const SizedBox(height: 24),
            Text('Esta autenticado: ${controller?.isAuthenticated.toString()}'),
            const SizedBox(height: 24),
            FilledButton(
              style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error),
              onPressed: () {
                controller?.logout();
                Modular.to.pushReplacementNamed('/');
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
