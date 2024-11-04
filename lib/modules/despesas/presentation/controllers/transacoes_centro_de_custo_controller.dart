import 'package:flutter/material.dart';
import 'package:teste_web/modules/despesas/domain/entities/filter_transacoes_centro_de_custo.dart';
import 'package:teste_web/modules/despesas/domain/entities/transacoes_centro_de_custo.dart';
import 'package:teste_web/modules/despesas/domain/usecases/get_transacoes_centro_de_custo_usecase.dart';

class TransacoesCentroDeCustoController extends ChangeNotifier {
  final GetTransacoesCentroDeCustoUsecase _getTransacoesCentroDeCustoUsecase;

  TransacoesCentroDeCustoController(this._getTransacoesCentroDeCustoUsecase);

  List<TransacoesCentroDeCusto> _transacoes = [];

  List<TransacoesCentroDeCusto> get transacoes => _transacoes;

  void getTransacoes(FilterTransacoesCentroDeCusto filtros) async {
    final result = await _getTransacoesCentroDeCustoUsecase(filtros);

    if (result != null) {
      _transacoes = result;
      notifyListeners();
    }
  }
}
