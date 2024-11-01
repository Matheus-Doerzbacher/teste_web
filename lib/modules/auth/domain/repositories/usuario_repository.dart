import 'package:teste_web/modules/auth/domain/entities/usuario_entity.dart';

abstract class LoginUsuarioRepository {
  Future<UsuarioEntity?> call(String login, String senha);
}

abstract class BuscarUsuarioByIdRepository {
  Future<UsuarioEntity?> call(String id, String token);
}
