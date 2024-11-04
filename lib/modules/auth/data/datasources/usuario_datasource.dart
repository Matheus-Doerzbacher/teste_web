import 'package:teste_web/modules/auth/domain/entities/usuario_entity.dart';

abstract class LoginUsuarioDatasource {
  Future<Usuario?> call(String login, String senha);
}

abstract class BuscarUsuarioByIdDatasource {
  Future<Usuario?> call(String id, String token);
}

abstract class GetImageBackgroundDatasource {
  Future<String> call();
}
