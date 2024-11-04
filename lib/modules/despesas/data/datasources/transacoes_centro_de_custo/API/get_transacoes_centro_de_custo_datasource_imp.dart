import 'dart:convert';

import 'package:teste_web/core/config.dart';
import 'package:teste_web/core/utils/db_print.dart';
import 'package:teste_web/modules/despesas/data/datasources/transacoes_centro_de_custo/transacoes_centro_de_custo_datasource.dart';
import 'package:teste_web/modules/despesas/domain/entities/filter_transacoes_centro_de_custo.dart';
import 'package:teste_web/modules/despesas/domain/entities/transacoes_centro_de_custo.dart';
import 'package:http/http.dart' as http;

class GetTransacoesCentroDeCustoDatasourceImp
    implements GetTransacoesCentroDeCustoDatasource {
  @override
  Future<List<TransacoesCentroDeCusto>?> call(
      FilterTransacoesCentroDeCusto filtros) async {
    try {
      List<TransacoesCentroDeCusto> transacoes = [];

      final queryParams = {
        if (filtros.dataVencimento != null)
          'dataVencimento_after':
              filtros.dataVencimento!.start.toIso8601String(),
        if (filtros.dataVencimento != null)
          'dataVencimento_before':
              filtros.dataVencimento!.end.toIso8601String(),
        if (filtros.dataRecebimento != null)
          'dataRecebimento_after':
              filtros.dataRecebimento!.start.toIso8601String(),
        if (filtros.dataRecebimento != null)
          'dataRecebimento_before':
              filtros.dataRecebimento!.end.toIso8601String(),
        if (filtros.fornecedor != null) 'fornecedor': filtros.fornecedor,
        if (filtros.itemDescricao != null)
          'itemDescricao': filtros.itemDescricao,
        if (filtros.planoConta != null) 'planoConta': filtros.planoConta,
        if (filtros.nomeOrg != null) 'nomeOrg': filtros.nomeOrg,
      };

      final uri = Uri.https(
        Config.apiUrl,
        'despesas/visao-centro-custo-transacao',
        queryParams,
      );
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        transacoes = parseData(jsonData);
      } else {
        dbPrint("Houve um erro ao buscar os centros de custos.");
        dbPrint("Status Erro: ${response.statusCode}");
      }

      return transacoes;
    } catch (error) {
      dbPrint('Houve um erro ao buscar os centros de custos');
      dbPrint(error);
    }
    return null;
  }
}
