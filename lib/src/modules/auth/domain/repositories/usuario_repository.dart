import 'package:teste_web/src/modules/auth/domain/entities/usuario_entity.dart';

abstract class LoginUsuarioRepository {
  Future<Usuario?> call(String login, String senha);
}

abstract class BuscarUsuarioByIdRepository {
  Future<Usuario?> call(String id, String token);
}

abstract class GetImageBackgroundRepository {
  Future<String> call();
}
