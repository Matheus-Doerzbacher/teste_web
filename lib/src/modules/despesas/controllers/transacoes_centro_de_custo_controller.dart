import 'package:flutter/material.dart';
import 'package:teste_web/src/modules/despesas/_models/filter_transacoes_centro_de_custo.dart';
import 'package:teste_web/src/modules/despesas/_models/transacoes_centro_de_custo.dart';
import 'package:teste_web/src/modules/despesas/repositories/get_trancacoes_centro_de_custo_repository.dart';

class TransacoesCentroDeCustoController extends ChangeNotifier {
  final GetTrancacoesCentroDeCustoRepository
      _getTransacoesCentroDeCustoRepository;

  TransacoesCentroDeCustoController(this._getTransacoesCentroDeCustoRepository);

  List<TransacoesCentroDeCusto> _transacoes = [];
  bool isLoading = false;

  List<TransacoesCentroDeCusto> get transacoes => _transacoes;

  Future<List<TransacoesCentroDeCusto>> getTransacoes(
      FilterTransacoesCentroDeCusto filtros) async {
    try {
      isLoading = true;
      notifyListeners();

      final result = await _getTransacoesCentroDeCustoRepository(filtros);

      if (result != null) {
        _transacoes = result;
        notifyListeners();
        return result;
      }

      return [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
