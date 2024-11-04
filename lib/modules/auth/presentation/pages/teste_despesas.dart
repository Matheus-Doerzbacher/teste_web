import 'package:flutter/material.dart';
import 'package:teste_web/core/widgets/drawer/drawer_navigation.dart';

class TesteDespesas extends StatelessWidget {
  const TesteDespesas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerNavigation(),
      body: const Center(
        child: Text('Teste despesas'),
      ),
    );
  }
}
