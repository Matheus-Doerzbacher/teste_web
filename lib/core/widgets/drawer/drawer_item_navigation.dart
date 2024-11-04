import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DrawerItemNavigation extends StatelessWidget {
  final String name;
  final IconData icon;
  final String currentPath;
  final String path;

  const DrawerItemNavigation({
    super.key,
    required this.name,
    required this.icon,
    required this.currentPath,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = currentPath == path;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      tileColor: isActive ? colorScheme.primaryContainer : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      leading: Icon(
        icon,
        size: 20,
      ),
      title: Text(
        name,
        style: textTheme.titleSmall,
      ),
      onTap: () {
        Modular.to.pop();
        Modular.to.pushNamed(path);
      },
      contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8),
    );
  }
}
