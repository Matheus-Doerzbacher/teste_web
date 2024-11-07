import 'package:teste_web/src/modules/despesas/domain/entities/filter_transacoes_centro_de_custo.dart';
import 'package:teste_web/src/modules/despesas/domain/entities/transacoes_centro_de_custo.dart';

abstract class GetTransacoesCentroDeCustoRepository {
  Future<List<TransacoesCentroDeCusto>?> call(
    FilterTransacoesCentroDeCusto filtros,
  );
}
