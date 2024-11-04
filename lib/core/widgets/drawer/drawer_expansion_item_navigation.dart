import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DrawerExpansionItemNavigation extends StatelessWidget {
  final String name;
  final String path;
  final String currentPath;

  const DrawerExpansionItemNavigation({
    super.key,
    required this.name,
    required this.path,
    required this.currentPath,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final isActive = currentPath == path;
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: ListTile(
        tileColor: isActive ? colorScheme.primaryContainer : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(
          name,
          style: textTheme.titleSmall
              ?.copyWith(color: colorScheme.onSurface.withOpacity(0.5)),
        ),
        onTap: () {
          Modular.to.pop();
          Modular.to.pushNamed(path);
        },
        contentPadding:
            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8),
        dense: true,
      ),
    );
  }
}
