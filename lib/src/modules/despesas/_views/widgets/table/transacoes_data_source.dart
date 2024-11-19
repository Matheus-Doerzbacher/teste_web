import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:teste_web/src/modules/despesas/_models/transacoes_centro_de_custo.dart';

class TransacoesDataSource extends DataGridSource {
  final BuildContext context;
  final List<TransacoesCentroDeCusto> transacoes;

  TransacoesDataSource({required this.transacoes, required this.context}) {
    _transacoes = transacoes.asMap().entries.map((entries) {
      final index = entries.key;
      final transacao = entries.value;

      return DataGridRow(cells: [
        //1
        DataGridCell<int>(columnName: 'Número', value: index + 1),
        //2
        const DataGridCell<String>(columnName: 'Detalhes', value: ''),
        //3
        DataGridCell<String>(columnName: '+/-', value: transacao.operacao),
        //4
        DataGridCell<int>(
            columnName: 'idTransacao', value: transacao.idTransacao),
        //5
        DataGridCell<String>(
            columnName: 'Fornecedor', value: transacao.fornecedor),
        //6
        DataGridCell<String>(
            columnName: 'Descrição', value: transacao.itemDescricao),
        //7
        const DataGridCell<int>(columnName: 'Parcelas', value: 1),
        //8
        DataGridCell<String>(
            columnName: 'Vencimento', value: transacao.dataVencimento),
        //9
        DataGridCell<String>(
            columnName: 'Pagamento',
            value: transacao.dataRecebimento ?? 'Não Pago'),
        //10
        DataGridCell<String>(
            columnName: 'Competência', value: transacao.dataCompetencia),
        //11
        DataGridCell<double>(columnName: 'Valor', value: transacao.valor),
        //12
        DataGridCell<double>(
            columnName: 'Encargos', value: transacao.valorEncargos ?? 0),
        //13
        DataGridCell<double>(
            columnName: 'Descontos', value: transacao.valorDescontos ?? 0),
        //14
        DataGridCell<double>(
            columnName: 'Pago', value: transacao.valorPago ?? 0),
        //15
        DataGridCell<String>(columnName: 'Situação', value: transacao.situacao),
        //16
        DataGridCell<String>(
            columnName: 'Plano de Conta', value: transacao.planoConta),
        //17
        DataGridCell<int>(columnName: 'Perfil', value: transacao.idPerfil),
        //18
        DataGridCell<String>(
            columnName: 'Prev. Pgto.',
            value: transacao.dataPrevisaoPagamento ?? 'Não Definido'),
        //19
        DataGridCell<double>(
            columnName: 'Original', value: transacao.valorOriginal),
        //20
        DataGridCell<String>(
            columnName: 'CPF/CNPJ',
            value: transacao.cpf ?? transacao.cnpj ?? 'Não Informado'),
        //21
        DataGridCell<String>(
            columnName: 'Conta', value: transacao.conta ?? 'Não Informado'),
        //22
        DataGridCell<String>(
            columnName: 'Tipo Pagamento',
            value: transacao.tipoPagamento ?? 'Não Informado'),
        //23
        DataGridCell<String>(
            columnName: 'Emissão', value: transacao.dataEmissao),
        //24
        DataGridCell<String>(
            columnName: 'Unidade Física',
            value: transacao.unidadeFisica ?? 'Não Informado'),
        //25
        DataGridCell<String>(columnName: 'Nome Org', value: transacao.nomeOrg),
      ]);
    }).toList();
  }

  List<DataGridRow> _transacoes = [];

  @override
  List<DataGridRow> get rows => _transacoes;

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Text(summaryValue),
    );
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final int rowIndex = _transacoes.indexOf(row);
    Color backgroundColor = Colors.transparent;
    if ((rowIndex % 2) == 0) {
      backgroundColor = Theme.of(context).colorScheme.primary.withOpacity(0.15);
    }

    return DataGridRowAdapter(
        color: backgroundColor,
        cells: row.getCells().map((dataGridCell) {
          bool isCenter = [
            'Número',
            '+/-',
            'Parcelas',
            'Valor',
            'Encargos',
            'Descontos',
            'Pago'
          ].contains(dataGridCell.columnName);

          return Container(
            alignment: isCenter ? Alignment.center : Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              dataGridCell.value?.toString() ?? '',
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList());
  }
}
