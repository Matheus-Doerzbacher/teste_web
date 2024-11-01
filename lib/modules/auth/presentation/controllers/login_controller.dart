import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teste_web/modules/auth/domain/usecases/login_usuario_usecase.dart';
import 'package:teste_web/modules/auth/presentation/controllers/auth_controller.dart';

class LoginController extends ChangeNotifier {
  final LoginUsuarioUsecase _loginUsuarioUsecase;
  final AuthController _authController;

  LoginController(this._loginUsuarioUsecase, this._authController);

  Future<bool> login(String login, String senha) async {
    try {
      final usuario = await _loginUsuarioUsecase(login, senha);

      if (usuario != null) {
        await _authController.saveUserData(usuario);
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

  Future<void> logout() async {
    await _authController.clearUserData();
  }

  Future<String?> getUrlImage() async {
    const photoPerPage = 15;
    final randomPage = Random().nextInt(5);

    final url = Uri.parse(
        'https://api.pexels.com/v1/search?query=nature&size=small&per_page=$photoPerPage&page=$randomPage');

    const token = 'L7VuojxY7hzgBwW61S2cZYoy9WLMUYDMQ7XNSpvF0lnoLfdRFjmNDIsJ';

    try {
      final response = await http.get(url, headers: {'Authorization': token});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final photos = data['photos'];
        final randomPhoto = photos[Random().nextInt(photoPerPage)];
        final url = randomPhoto['src']['original'];
        return url;
      }
    } catch (error) {
      throw Exception('Erro ao buscar imagem de background');
    }
    return null;
  }
}
