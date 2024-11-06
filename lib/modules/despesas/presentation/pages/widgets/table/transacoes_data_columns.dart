import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

List<GridColumn> transacoesColumns() {
  return <GridColumn>[
    // 1
    GridColumn(
      columnName: 'Número',
      label: _gridContainer('Número'),
    ),
    // 2
    GridColumn(
      columnName: 'Detalhes',
      label: _gridContainer('Detalhes'),
    ),
    // 3
    GridColumn(
      columnName: '+/-',
      label: _gridContainer('+/-'),
    ),
    // 4
    GridColumn(
      columnName: 'idTransacao',
      label: _gridContainer('idTransação'),
    ),
    // 5
    GridColumn(
      width: 200,
      columnName: 'Fornecedor',
      label: _gridContainer('Fornecedor'),
    ),
    // 6
    GridColumn(
      width: 200,
      columnName: 'Descrição',
      label: _gridContainer('Descrição'),
    ),
    // 7
    GridColumn(
      columnName: 'Parcelas',
      label: _gridContainer('Parcelas'),
    ),
    // 8
    GridColumn(
      columnName: 'Vencimento',
      label: _gridContainer('Vencimento'),
    ),
    // 9
    GridColumn(
      columnName: 'Pagamento',
      label: _gridContainer('Pagamento'),
    ),
    // 10
    GridColumn(
      columnName: 'Competência',
      label: _gridContainer('Competência'),
    ),
    // 11
    GridColumn(
      columnName: 'Valor',
      label: _gridContainer('Valor'),
    ),
    // 12
    GridColumn(
      columnName: 'Encargos',
      label: _gridContainer('Encargos'),
    ),
    // 13
    GridColumn(
      columnName: 'Descontos',
      label: _gridContainer('Descontos'),
    ),
    // 14
    GridColumn(
      columnName: 'Pago',
      label: _gridContainer('Pago'),
    ),
    // 15
    GridColumn(
      columnName: 'Situação',
      label: _gridContainer('Situação'),
    ),
    // 16
    GridColumn(
      columnName: 'Plano de Conta',
      label: _gridContainer('Plano de Conta'),
    ),
    // 17
    GridColumn(
      columnName: 'Perfil',
      label: _gridContainer('Perfil'),
    ),
    // 18
    GridColumn(
      columnName: 'Prev. Pgto.',
      label: _gridContainer('Prev. Pgto.'),
    ),
    // 19
    GridColumn(
      columnName: 'Original',
      label: _gridContainer('Original'),
    ),
    // 20
    GridColumn(
      columnName: 'CPF/CNPJ',
      label: _gridContainer('CPF/CNPJ'),
    ),
    // 21
    GridColumn(
      width: 100,
      columnName: 'Conta',
      label: _gridContainer('Conta'),
    ),
    // 22
    GridColumn(
      columnName: 'Tipo Pagamento',
      label: _gridContainer('Tipo Pagamento'),
    ),
    // 23
    GridColumn(
      width: 100,
      columnName: 'Emissão',
      label: _gridContainer('Emissão'),
    ),
    // 24
    GridColumn(
      columnName: 'Unidade Física',
      label: _gridContainer('Unidade Física'),
    ),
    // 25
    GridColumn(
      width: 200,
      columnName: 'Nome Org',
      label: _gridContainer('Nome Org'),
    ),
  ];
}

Container _gridContainer(String columName) {
  return Container(
    decoration: const BoxDecoration(
      border: Border(
        left: BorderSide(color: Colors.grey, width: 1.5),
      ),
    ),
    alignment: Alignment.center,
    child: Text(
      columName,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

List<GridTableSummaryRow> loadTableSummaryRows() {
  return <GridTableSummaryRow>[
    GridTableSummaryRow(
      color: Colors.green.shade100,
      showSummaryInRow: false,
      columns: <GridSummaryColumn>[
        const GridSummaryColumn(
          name: 'Valor',
          columnName: 'Valor',
          summaryType: GridSummaryType.sum,
        ),
        const GridSummaryColumn(
          name: 'Encargos',
          columnName: 'Encargos',
          summaryType: GridSummaryType.sum,
        ),
      ],
      position: GridTableSummaryRowPosition.bottom,
    ),
  ];
}
