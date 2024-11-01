import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teste_web/core/config.dart';
import 'package:teste_web/core/utils/db_print.dart';
import 'package:teste_web/modules/auth/data/datasources/usuario_datasource.dart';
import 'package:teste_web/modules/auth/domain/entities/usuario_entity.dart';

class BuscarUsuarioByIdDatasourceImp implements BuscarUsuarioByIdDatasource {
  @override
  Future<UsuarioEntity?> call(String id, String token) async {
    try {
      final url = Uri.parse('${Config.apiUrl}usuarios/$id/');
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        UsuarioEntity usuario =
            UsuarioEntity.fromJson({'token': token, 'user': json});
        return usuario.copyWith(token: token);
      } else {
        dbPrint('Erro na requisição buscar usuário: ${response.statusCode}');
      }
    } catch (e) {
      dbPrint('Erro ao buscar usuário');
      dbPrint(e);
    }
    return null;
  }
}
