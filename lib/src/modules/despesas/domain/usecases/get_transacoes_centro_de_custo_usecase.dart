import 'package:teste_web/src/modules/despesas/domain/entities/filter_transacoes_centro_de_custo.dart';
import 'package:teste_web/src/modules/despesas/domain/entities/transacoes_centro_de_custo.dart';
import 'package:teste_web/src/modules/despesas/domain/repositories/transacoes_centro_de_custo_repository.dart';

abstract class GetTransacoesCentroDeCustoUsecase {
  Future<List<TransacoesCentroDeCusto>?> call(
    FilterTransacoesCentroDeCusto filtros,
  );
}

class GetTransacoesCentroDeCustoUsecaseImp
    implements GetTransacoesCentroDeCustoUsecase {
  final GetTransacoesCentroDeCustoRepository
      _getTransacoesCentroDeCustoRepository;

  GetTransacoesCentroDeCustoUsecaseImp(
      this._getTransacoesCentroDeCustoRepository);

  @override
  Future<List<TransacoesCentroDeCusto>?> call(
      FilterTransacoesCentroDeCusto filtros) {
    return _getTransacoesCentroDeCustoRepository(filtros);
  }
}
