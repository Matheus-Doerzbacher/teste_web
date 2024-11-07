import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_web/core/widgets/drawer/drawer_expansion_panel_list.dart';
import 'package:teste_web/core/widgets/drawer/drawer_item_navigation.dart';
import 'package:teste_web/src/modules/auth/presentation/controllers/auth_controller.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({super.key});

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  final usuario = AuthController.usuario;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentPath = Modular.to.path;
    return Drawer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                Image.asset(
                  'assets/images/logo-uniguacu.png',
                  width: 160,
                ),
                const Spacer(),
                IconButton(
                  tooltip: 'Fechar navegação',
                  onPressed: () {
                    Modular.to.pop();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                children: [
                  DrawerItemNavigation(
                    currentPath: currentPath,
                    path: '/',
                    icon: Icons.home,
                    name: 'Página Principal',
                  ),
                  DrawerExpansionPanelList(currentPath: currentPath),
                ],
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: CircleAvatar(
              child: Text(
                usuario?.name[0] ?? '',
              ),
            ),
            title: Text(
              usuario?.name ?? '',
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              usuario?.email ?? '',
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              // Ação ao clicar
            },
          ),
        ],
      ),
    );
  }
}
