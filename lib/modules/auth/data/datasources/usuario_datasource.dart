import 'package:teste_web/modules/auth/domain/entities/usuario_entity.dart';

abstract class LoginUsuarioDatasource {
  Future<UsuarioEntity?> call(String login, String senha);
}

abstract class BuscarUsuarioByIdDatasource {
  Future<UsuarioEntity?> call(String id, String token);
}
