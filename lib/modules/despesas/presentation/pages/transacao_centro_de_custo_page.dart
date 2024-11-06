// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:teste_web/core/widgets/drawer/drawer_navigation.dart';
import 'package:teste_web/modules/despesas/domain/entities/filter_transacoes_centro_de_custo.dart';
import 'package:teste_web/modules/despesas/presentation/controllers/transacoes_centro_de_custo_controller.dart';
import 'package:teste_web/modules/despesas/presentation/pages/widgets/date_rage_widget.dart';
import 'package:teste_web/modules/despesas/presentation/pages/widgets/table/transacoes_data_columns.dart';
import 'package:teste_web/modules/despesas/presentation/pages/widgets/table/transacoes_data_source.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class TransacaoCentroDeCustoPage extends StatefulWidget {
  const TransacaoCentroDeCustoPage({super.key});

  @override
  State<TransacaoCentroDeCustoPage> createState() =>
      _TransacaoCentroDeCustoPageState();
}

class _TransacaoCentroDeCustoPageState
    extends State<TransacaoCentroDeCustoPage> {
  final FocusNode _buttonFocusNode = FocusNode(debugLabel: 'Menu Button');

  final _fornecedorController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _planoContraController = TextEditingController();
  final _nomeOrgController = TextEditingController();

  DateTimeRange? _dataVencimentoRange;
  late DateTimeRange? _dataRecibimentoRange;

  final controller = Modular.get<TransacoesCentroDeCustoController>();

  late TransacoesDataSource transacoesDataSource;

  @override
  void initState() {
    _dataRecibimentoRange = DateTimeRange(
      start: DateTime(DateTime.now().year, DateTime.now().month, 1),
      end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
    );

    final filtros =
        FilterTransacoesCentroDeCusto(dataRecebimento: _dataRecibimentoRange);

    controller.getTransacoes(filtros).then((listTransacoes) {
      if (mounted) {
        transacoesDataSource =
            TransacoesDataSource(transacoes: listTransacoes, context: context);
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _fornecedorController.dispose();
    _descricaoController.dispose();
    _planoContraController.dispose();
    _nomeOrgController.dispose();
    _buttonFocusNode.dispose();
    super.dispose();
  }

  void _buscarTransacoes() async {
    final filters = FilterTransacoesCentroDeCusto(
      fornecedor: _fornecedorController.text,
      itemDescricao: _descricaoController.text,
      planoConta: _planoContraController.text,
      nomeOrg: _nomeOrgController.text,
      dataRecebimento: _dataRecibimentoRange,
      dataVencimento: _dataVencimentoRange,
    );

    controller.getTransacoes(filters).then((listTransacoes) {
      if (mounted) {
        transacoesDataSource =
            TransacoesDataSource(transacoes: listTransacoes, context: context);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: screenWidth < 800
          ? FloatingActionButton(
              onPressed: () {
                // Ação do botão flutuante
              },
              child: const Icon(Icons.search),
            )
          : Container(),
      appBar: AppBar(
        title: const Text('Centro de Custo'),
        actions: [
          screenWidth < 800
              ? _myCascadingMenu(context)
              : Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.download),
                      label: const Text('Baixar CSV'),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('Limpar Filtros'),
                    ),
                    const SizedBox(width: 16),
                    FilledButton.icon(
                      onPressed: _buscarTransacoes,
                      icon: const Icon(Icons.search),
                      label: const Text('Buscar'),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0), // Altura da linha
          child: Container(
            color: Theme.of(context)
                .colorScheme
                .onSurface
                .withOpacity(0.15), // Cor da linha
            height: 1.5, // Espessura da linha
          ),
        ),
      ),
      drawer: const DrawerNavigation(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _filtrosTextoDePesquisa(context),
            const SizedBox(height: 24),
            _filtroDatasPesquisa(context),
            Container(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withOpacity(0.15), // Cor da linha
              height: 1.5, // Espessura da linha
            ),
            controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : controller.transacoes.isNotEmpty
                    ? Expanded(
                        child: SfDataGridTheme(
                          data: SfDataGridThemeData(
                            headerHoverColor: Colors.white.withOpacity(0.3),
                            headerColor: Theme.of(context).colorScheme.primary,
                            sortIconColor: Colors.white,
                          ),
                          child: SfDataGrid(
                            source: transacoesDataSource,
                            columns: transacoesColumns(),
                            // allowSorting: true,
                            // gridLinesVisibility: GridLinesVisibility.both,
                            // headerGridLinesVisibility: GridLinesVisibility.both,
                            // columnWidthMode: ColumnWidthMode.fitByColumnName,
                            // columnWidthCalculationRange:
                            //     ColumnWidthCalculationRange.allRows,
                            tableSummaryRows: loadTableSummaryRows(),
                          ),
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 64),
                          Text(
                            'Nenhuma transacão encontrada',
                          ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }

  Widget _filtrosTextoDePesquisa(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return Column(
            // Muda para Column em telas menores
            children: [
              _buildTextField(_fornecedorController, 'Fornecedor'),
              const SizedBox(height: 16),
              _buildTextField(_descricaoController, 'Descrição'),
              const SizedBox(height: 16),
              _buildTextField(_planoContraController, 'Plano de Conta'),
              const SizedBox(height: 16),
              _buildTextField(_nomeOrgController, 'Nome da Organização'),
            ],
          );
        } else {
          return Row(
            // Mantém Row em telas maiores
            children: [
              Expanded(
                  child: _buildTextField(_fornecedorController, 'Fornecedor')),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildTextField(_descricaoController, 'Descrição')),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildTextField(
                      _planoContraController, 'Plano de Conta')),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildTextField(
                      _nomeOrgController, 'Nome da Organização')),
            ],
          );
        }
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
      ),
    );
  }

  Widget _filtroDatasPesquisa(BuildContext context) {
    return DateRageWidget(
      dataVencimento: _dataVencimentoRange,
      dataRecebimento: _dataRecibimentoRange,
      onVencimentoChanged: (DateTimeRange? range) {
        setState(() {
          _dataVencimentoRange = range;
        });
      },
      onRecebimentoChanged: (DateTimeRange? range) {
        setState(() {
          _dataRecibimentoRange = range;
        });
      },
    );
  }

  Widget _myCascadingMenu(BuildContext context) {
    return MenuAnchor(
      childFocusNode: _buttonFocusNode,
      menuChildren: <Widget>[
        MenuItemButton(
          onPressed: () {
            // Ação para Baixar CSV
          },
          child: const Text('Baixar CSV'),
        ),
        MenuItemButton(
          onPressed: () {
            // Ação para Limpar Filtros
          },
          child: const Text('Limpar Filtros'),
        ),
      ],
      builder: (_, MenuController controller, Widget? child) {
        return IconButton(
          focusNode: _buttonFocusNode,
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Icons.more_vert),
        );
      },
    );
  }
}
