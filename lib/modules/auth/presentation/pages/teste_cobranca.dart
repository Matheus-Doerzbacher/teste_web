import 'package:flutter/material.dart';
import 'package:teste_web/core/widgets/drawer/drawer_navigation.dart';

class TesteCobranca extends StatelessWidget {
  const TesteCobranca({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerNavigation(),
      body: const Center(
        child: Text('Teste Cobranca'),
      ),
    );
  }
}
