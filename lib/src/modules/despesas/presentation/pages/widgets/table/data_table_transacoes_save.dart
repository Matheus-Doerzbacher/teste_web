import 'package:flutter/material.dart';
import 'package:teste_web/src/modules/despesas/domain/entities/transacoes_centro_de_custo.dart';

class DataTableTransacoes extends StatelessWidget {
  final List<TransacoesCentroDeCusto> transacoes;

  const DataTableTransacoes({super.key, required this.transacoes});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTableTheme(
            data: DataTableThemeData(
              headingRowColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.primary),
              headingTextStyle: const TextStyle(
                color: Colors.white, // Cor do texto do cabeçalho
                fontWeight: FontWeight.bold,
              ),
            ),
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Número')),
                DataColumn(label: Text('Detalhes')),
                DataColumn(label: Text('+/-')),
                DataColumn(label: Text('idTransação')),
                DataColumn(label: Text('Fornecedor')),
                DataColumn(label: Text('Descrição')),
                DataColumn(label: Text('Parcelas')),
                DataColumn(label: Text('Vencimento')),
                DataColumn(label: Text('Pagamento')),
                DataColumn(label: Text('Competência')),
                DataColumn(label: Text('Valor')),
                DataColumn(label: Text('Encargos')),
                DataColumn(label: Text('Descontos')),
                DataColumn(label: Text('Pago')),
                DataColumn(label: Text('Situação')),
                DataColumn(label: Text('Plano de Conta')),
                DataColumn(label: Text('Perfil')),
                DataColumn(label: Text('Prev. Pgto.')),
                DataColumn(label: Text('Original')),
                DataColumn(label: Text('CPF/CNPJ')),
                DataColumn(label: Text('Conta')),
                DataColumn(label: Text('Tipo Pagamento')),
                DataColumn(label: Text('Emissão')),
                DataColumn(label: Text('Unidade Física')),
                DataColumn(label: Text('Nome Org')),
              ],
              rows: transacoes.asMap().entries.map((entry) {
                final index = entry.key;
                TransacoesCentroDeCusto transacao = entry.value;

                return DataRow(
                  color: index % 2 != 0
                      ? WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.surfaceContainer)
                      : null,
                  cells: [
                    DataCell(Text((index + 1).toString())),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.info_outline),
                            onPressed: () {
                              _showCentroDeCustoDialog(
                                  context, transacao.centroDeCusto);
                            },
                          ),
                          Text(transacao.centroDeCusto.length.toString())
                        ],
                      ),
                    ),
                    DataCell(Text(transacao.operacao)),
                    DataCell(Text(transacao.idTransacao.toString())),
                    DataCell(
                      Container(
                          constraints: const BoxConstraints(maxWidth: 200),
                          child: Text(
                            transacao.fornecedor,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ),
                    DataCell(
                      Container(
                          constraints: const BoxConstraints(maxWidth: 300),
                          child: Text(
                            transacao.itemDescricao,
                            overflow: TextOverflow.ellipsis,
                          )),
                    ),
                    DataCell(Text(transacao.numeroParcela)),
                    DataCell(Text(transacao.dataVencimento)),
                    DataCell(Text(transacao.dataRecebimento ?? '')),
                    DataCell(Text(transacao.dataCompetencia)),
                    DataCell(Text(transacao.valor.toStringAsFixed(2))),
                    DataCell(
                      Text(transacao.valorEncargos?.toStringAsFixed(2) ?? ''),
                    ),
                    DataCell(
                      Text(transacao.valorDescontos?.toStringAsFixed(2) ?? ''),
                    ),
                    DataCell(
                      Text(transacao.valorPago?.toStringAsFixed(2) ?? ''),
                    ),
                    DataCell(Text(transacao.situacao,
                        style: TextStyle(
                            color: transacao.situacao == 'PAGO'
                                ? Colors.green
                                : null))),
                    DataCell(Text(transacao.planoConta)),
                    const DataCell(Text('')),
                    const DataCell(Text('')),
                    const DataCell(Text('')),
                    const DataCell(Text('')),
                    const DataCell(Text('')),
                    const DataCell(Text('')),
                    const DataCell(Text('')),
                    const DataCell(Text('')),
                    const DataCell(Text('')),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _showCentroDeCustoDialog(
      BuildContext context, List<CentroDeCusto> centroDeCustoList) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Detalhes do Centro de Custo'),
          content: SizedBox(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: centroDeCustoList.length,
              itemBuilder: (context, index) {
                final centroDeCusto = centroDeCustoList[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(centroDeCusto.nomeCentroCustos),
                    Text(
                        'R\$ ${centroDeCusto.valorCentroCusto.toStringAsFixed(2)}')
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
