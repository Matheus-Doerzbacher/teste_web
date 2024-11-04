import 'package:teste_web/modules/despesas/data/datasources/transacoes_centro_de_custo/transacoes_centro_de_custo_datasource.dart';
import 'package:teste_web/modules/despesas/domain/entities/filter_transacoes_centro_de_custo.dart';
import 'package:teste_web/modules/despesas/domain/entities/transacoes_centro_de_custo.dart';
import 'package:teste_web/modules/despesas/domain/repositories/transacoes_centro_de_custo_repository.dart';

class GetTransacaoesCentroDeCustoRepositoryImp
    implements GetTransacoesCentroDeCustoRepository {
  final GetTransacoesCentroDeCustoDatasource
      _getTransacoesCentroDeCustoDatasource;

  GetTransacaoesCentroDeCustoRepositoryImp(
      this._getTransacoesCentroDeCustoDatasource);

  @override
  Future<List<TransacoesCentroDeCusto>?> call(
      FilterTransacoesCentroDeCusto filtros) {
    return _getTransacoesCentroDeCustoDatasource(filtros);
  }
}
