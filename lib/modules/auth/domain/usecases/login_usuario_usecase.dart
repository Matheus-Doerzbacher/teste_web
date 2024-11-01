import 'package:teste_web/modules/auth/domain/entities/usuario_entity.dart';
import 'package:teste_web/modules/auth/domain/repositories/usuario_repository.dart';

abstract class LoginUsuarioUsecase {
  Future<UsuarioEntity?> call(String login, String senha);
}

class LoginUsuarioUsecaseImp implements LoginUsuarioUsecase {
  final LoginUsuarioRepository _loginUsuarioRepository;

  LoginUsuarioUsecaseImp(this._loginUsuarioRepository);

  @override
  Future<UsuarioEntity?> call(String login, String senha) {
    return _loginUsuarioRepository(login, senha);
  }
}
