import 'package:flutter/material.dart';

class FilterTransacoesCentroDeCusto {
  final DateTimeRange? dataVencimento;
  final DateTimeRange? dataRecebimento;
  final String? fornecedor;
  final String? itemDescricao;
  final String? planoConta;
  final String? nomeOrg;

  FilterTransacoesCentroDeCusto({
    this.dataVencimento,
    this.dataRecebimento,
    this.fornecedor,
    this.itemDescricao,
    this.planoConta,
    this.nomeOrg,
  });
}
