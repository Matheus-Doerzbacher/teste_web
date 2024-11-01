import 'package:flutter/material.dart';
import 'package:teste_web/core/utils/db_print.dart';
import 'package:teste_web/core/utils/repository.dart';
import 'package:teste_web/modules/auth/domain/entities/usuario_entity.dart';
import 'package:teste_web/modules/auth/domain/usecases/buscar_usuario_by_id_usecase.dart';

class AuthController extends ChangeNotifier {
  final BuscarUsuarioByIdUsecase _buscarUsuarioByIdUsecase;

  AuthController(this._buscarUsuarioByIdUsecase);

  UsuarioEntity? _usuario;

  UsuarioEntity? get usuario => _usuario;

  // Salva os dados do usuário em JSON criptografado
  Future<void> saveUserData(UsuarioEntity usuario) async {
    _usuario = usuario;
    notifyListeners();

    await Repository.save('auth_token', usuario.token);
    await Repository.save('id_user', usuario.id.toString());
  }

  // Carrega os dados do usuário e decodifica o JSON
  Future<void> loadUserData() async {
    try {
      final token = await Repository.read('auth_token');
      final idUser = await Repository.read('id_user');

      if (token == null || idUser == null) {
        _usuario = null;
      } else {
        _usuario = await _buscarUsuarioByIdUsecase(idUser, token);
      }
      notifyListeners();
    } catch (e) {
      dbPrint('Houve um erro ao buscar os dados do usuario');
      dbPrint(e);
    }
    return;
  }

  // Remove os dados do usuário
  Future<void> clearUserData() async {
    _usuario = null;
    notifyListeners();
    await Repository.remove('auth_token');
    await Repository.remove('id_user');
  }

  // Método para verificar se o usuário está autenticado
  bool get isAuthenticated => _usuario != null;
}
