import 'package:flutter/material.dart';
import 'package:teste_web/core/utils/db_print.dart';
import 'package:teste_web/core/utils/repository.dart';
import 'package:teste_web/modules/auth/domain/entities/usuario_entity.dart';

class AuthController extends ChangeNotifier {
  UsuarioEntity? _usuario;

  UsuarioEntity? get usuario => _usuario;

  bool get isAuthenticated => _usuario != null;

  Future<void> loadUserData() async {
    try {
      // final token = await Repository.read('auth_token');
      // final idUser = await Repository.read('id_user');

      // if (token != null && idUser != null) {
      //   _usuario = await _buscarUsuarioByIdUsecase(idUser, token);
      // } else {
      //   _usuario = null;
      // }

      final userJson = await Repository.read('user_data');

      if (userJson != null) {
        _usuario = UsuarioEntity.fromJson(userJson);
      }
      notifyListeners();
    } catch (e) {
      dbPrint('Houve um erro ao buscar os dados do usuario');
      dbPrint(e);
    }
  }

  Future<void> saveUserData(UsuarioEntity usuario) async {
    _usuario = usuario;
    notifyListeners();

    final userJson = usuario.toJson();

    await Repository.save('user_data', userJson);
    // await Repository.save('auth_token', usuario.token);
    // await Repository.save('id_user', usuario.id.toString());
  }

  Future<void> clearUserData() async {
    _usuario = null;
    notifyListeners();
    await Repository.remove('user_data');
    // await Repository.remove('auth_token');
    // await Repository.remove('id_user');
  }
}
