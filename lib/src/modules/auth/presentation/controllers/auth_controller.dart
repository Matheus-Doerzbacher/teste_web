import 'package:flutter/material.dart';
import 'package:teste_web/core/utils/db_print.dart';
import 'package:teste_web/core/utils/repository.dart';
import 'package:teste_web/src/modules/auth/domain/entities/usuario_entity.dart';
import 'package:teste_web/src/modules/auth/domain/usecases/get_image_background_usecase.dart';
import 'package:teste_web/src/modules/auth/domain/usecases/login_usuario_usecase.dart';

class AuthController extends ChangeNotifier {
  final LoginUsuarioUsecase _loginUsuarioUsecase;
  final GetImageBackgroundUsecase _getImageBackgroundUsecase;

  AuthController(this._loginUsuarioUsecase, this._getImageBackgroundUsecase);

  static Usuario? _usuario;

  static Usuario? get usuario => _usuario;

  bool get isAuthenticated => _usuario != null;

  Future<bool> login(String login, String senha) async {
    try {
      final usuario = await _loginUsuarioUsecase(login, senha);

      if (usuario != null) {
        _usuario = usuario;
        notifyListeners();

        await saveUserData(usuario);
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

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
        _usuario = Usuario.fromJson(userJson);
      }
      notifyListeners();
    } catch (e) {
      dbPrint('Houve um erro ao buscar os dados do usuario');
      dbPrint(e);
    }
  }

  Future<void> saveUserData(Usuario usuario) async {
    final userJson = usuario.toJson();

    await Repository.save('user_data', userJson);
    // await Repository.save('auth_token', usuario.token);
    // await Repository.save('id_user', usuario.id.toString());
  }

  Future<void> logout() async {
    _usuario = null;
    notifyListeners();
    await Repository.remove('user_data');
    // await Repository.remove('auth_token');
    // await Repository.remove('id_user');
  }

  Future<String?> getUrlImage() {
    return _getImageBackgroundUsecase();
  }
}
