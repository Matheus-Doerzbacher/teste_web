import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:teste_web/core/config.dart';
import 'package:teste_web/core/utils/db_print.dart';
import 'package:teste_web/modules/auth/presentation/controllers/auth_controller.dart';
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
              DateFormat('yyyy-MM-dd').format(filtros.dataVencimento!.start),
        if (filtros.dataVencimento != null)
          'dataVencimento_before':
              DateFormat('yyyy-MM-dd').format(filtros.dataVencimento!.end),
        if (filtros.dataRecebimento != null)
          'dataRecebimento_after':
              DateFormat('yyyy-MM-dd').format(filtros.dataRecebimento!.start),
        if (filtros.dataRecebimento != null)
          'dataRecebimento_before':
              DateFormat('yyyy-MM-dd').format(filtros.dataRecebimento!.end),
        if (filtros.fornecedor != null) 'fornecedor': filtros.fornecedor,
        if (filtros.itemDescricao != null)
          'itemDescricao': filtros.itemDescricao,
        if (filtros.planoConta != null) 'planoConta': filtros.planoConta,
        if (filtros.nomeOrg != null) 'nomeOrg': filtros.nomeOrg,
      };

      final uri = Uri.parse(
        '${Config.apiUrl}despesas/visao-centro-custo-transacao/',
      ).replace(queryParameters: queryParams);

      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer ${AuthController.usuario?.token}'
      });

      if (response.statusCode == 200) {
        // Decodifique a resposta como UTF-8
        final decodedData = utf8.decode(response.bodyBytes);
        final List<dynamic> jsonData = jsonDecode(decodedData);
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
