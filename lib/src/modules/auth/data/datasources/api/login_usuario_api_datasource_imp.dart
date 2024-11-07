import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:teste_web/core/config.dart';
import 'package:teste_web/core/utils/db_print.dart';
import 'package:teste_web/src/modules/auth/data/datasources/usuario_datasource.dart';
import 'package:teste_web/src/modules/auth/domain/entities/usuario_entity.dart';

class LoginUsuarioApiDatasourceImp implements LoginUsuarioDatasource {
  @override
  Future<Usuario?> call(String login, String senha) async {
    try {
      final url = Uri.parse('${Config.apiUrl}login/');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            'username': login, // Ajuste com aspas ao redor da chave
            'password': senha, // Ajuste com aspas ao redor da chave
          },
        ),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final usuario = Usuario.fromJson(json);
        return usuario;
      } else {
        dbPrint('Erro ao buscar usuario');
        dbPrint(jsonDecode(response.body)['error']);
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      throw Exception('Erro ao fazer o login');
    }
    return null;
  }
}
