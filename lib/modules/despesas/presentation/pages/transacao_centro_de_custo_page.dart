import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_web/core/widgets/drawer/drawer_navigation.dart';
import 'package:teste_web/modules/despesas/presentation/controllers/transacoes_centro_de_custo_controller.dart';
import 'package:teste_web/modules/despesas/presentation/pages/widgets/date_rage_widget.dart';

class TransacaoCentroDeCustoPage extends StatefulWidget {
  const TransacaoCentroDeCustoPage({super.key});

  @override
  State<TransacaoCentroDeCustoPage> createState() =>
      _TransacaoCentroDeCustoPageState();
}

class _TransacaoCentroDeCustoPageState
    extends State<TransacaoCentroDeCustoPage> {
  final _fornecedorController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _planoContraController = TextEditingController();
  final _nomeOrgController = TextEditingController();

  DateTimeRange? _dataVencimentoRange;
  DateTimeRange? _dataRecibimentoRange;

  final controller = Modular.get<TransacoesCentroDeCustoController>();

  @override
  void dispose() {
    _fornecedorController.dispose();
    _descricaoController.dispose();
    _planoContraController.dispose();
    _nomeOrgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centro de Custo'),
        actions: [
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
            onPressed: () {},
            icon: const Icon(Icons.search),
            label: const Text('Buscar'),
          ),
          const SizedBox(width: 16),
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
            controller.transacoes.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                    itemCount: controller.transacoes.length,
                    itemBuilder: (context, index) {
                      final transacao = controller.transacoes[index];
                      return ListTile(
                        title: Text(transacao.fornecedor),
                        subtitle: Column(
                            children: transacao.centroDeCusto
                                .map((centro) => Text(centro.nomeCentroCustos))
                                .toList()),
                      );
                    },
                  ))
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
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _fornecedorController,
            decoration: const InputDecoration(
              label: Text('Fornecedor'),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: _descricaoController,
            decoration: const InputDecoration(
              label: Text('Descrição'),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: _planoContraController,
            decoration: const InputDecoration(
              label: Text('Plano de Conta'),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: _nomeOrgController,
            decoration: const InputDecoration(
              label: Text('Nome da Organização'),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
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
}
