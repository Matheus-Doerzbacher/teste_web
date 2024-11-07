import 'package:teste_web/src/modules/auth/domain/entities/usuario_entity.dart';
import 'package:teste_web/src/modules/auth/domain/repositories/usuario_repository.dart';

abstract class LoginUsuarioUsecase {
  Future<Usuario?> call(String login, String senha);
}

class LoginUsuarioUsecaseImp implements LoginUsuarioUsecase {
  final LoginUsuarioRepository _loginUsuarioRepository;

  LoginUsuarioUsecaseImp(this._loginUsuarioRepository);

  @override
  Future<Usuario?> call(String login, String senha) {
    return _loginUsuarioRepository(login, senha);
  }
}
