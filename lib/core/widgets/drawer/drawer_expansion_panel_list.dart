import 'package:flutter/material.dart';
import 'package:teste_web/core/widgets/drawer/drawer_expansion_item_navigation.dart';

class DrawerExpansionPanelList extends StatefulWidget {
  final String currentPath;
  const DrawerExpansionPanelList({super.key, required this.currentPath});

  @override
  State<DrawerExpansionPanelList> createState() =>
      _DrawerExpansionPanelListState();
}

class _DrawerExpansionPanelListState extends State<DrawerExpansionPanelList> {
  late List<Item> _data;
  @override
  void initState() {
    _data = [
      Item(
        id: 0,
        icon: Icons.receipt,
        headerValue: 'Cobranca',
        expandedValue: [
          DrawerExpansionItemNavigation(
            name: 'Lista de Distribuições',
            path: '/cobranca/lista-distribuicao',
            currentPath: widget.currentPath,
          ),
          DrawerExpansionItemNavigation(
            name: 'Bi Cobranca',
            path: '/cobranca/bi-cobranca',
            currentPath: widget.currentPath,
          )
        ],
      ),
      Item(
        id: 1,
        icon: Icons.money_off,
        headerValue: 'Despesas',
        expandedValue: [
          DrawerExpansionItemNavigation(
            name: 'Centro de Custo',
            path: '/despesas/centro-custo',
            currentPath: widget.currentPath,
          )
        ],
      ),
      Item(
        id: 2,
        icon: Icons.admin_panel_settings,
        headerValue: 'Administrador',
        expandedValue: [
          DrawerExpansionItemNavigation(
            name: 'Permissões',
            path: '/administrador/permissoes',
            currentPath: widget.currentPath,
          )
        ],
      )
    ];
    super.initState();
  }

  int? indexActivated() {
    final path = widget.currentPath;
    if (path.contains('cobranca')) {
      return 0;
    } else if (path.contains('despesas')) {
      return 1;
    } else if (path.contains('administrador')) {
      return 2;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: _buildPanel(context));
  }

  Widget _buildPanel(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ExpansionPanelList.radio(
      elevation: 0,
      dividerColor: Colors.transparent,
      materialGapSize: 0,
      expandedHeaderPadding: const EdgeInsets.all(0),
      initialOpenPanelValue: indexActivated(),
      //
      children: _data.map<ExpansionPanelRadio>((Item item) {
        return ExpansionPanelRadio(
          backgroundColor: colorScheme.surfaceContainerLow,
          //
          value: item.id,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              // tileColor: Colors.red,
              leading: Icon(
                item.icon,
                size: 20,
              ),
              title: Text(
                item.headerValue,
                style: textTheme.titleSmall,
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              contentPadding: const EdgeInsets.only(left: 8),
            );
          },
          body: Column(children: item.expandedValue),
        );
      }).toList(),
    );
  }
}

class Item {
  Item(
      {required this.id,
      required this.expandedValue,
      required this.headerValue,
      required this.icon});

  int id;
  List<DrawerExpansionItemNavigation> expandedValue;
  String headerValue;
  IconData icon;
}
