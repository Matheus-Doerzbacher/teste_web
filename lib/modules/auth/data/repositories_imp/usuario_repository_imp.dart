import 'package:teste_web/modules/auth/data/datasources/usuario_datasource.dart';
import 'package:teste_web/modules/auth/domain/entities/usuario_entity.dart';
import 'package:teste_web/modules/auth/domain/repositories/usuario_repository.dart';

class LoginUsuarioRepositoryImp implements LoginUsuarioRepository {
  final LoginUsuarioDatasource _loginUsuarioDatasource;

  LoginUsuarioRepositoryImp(this._loginUsuarioDatasource);

  @override
  Future<Usuario?> call(String login, String senha) {
    return _loginUsuarioDatasource(login, senha);
  }
}

////////////////////////////////////////////////////////////////////////////////

class BuscarUsuarioByIdRepositoryImp implements BuscarUsuarioByIdRepository {
  final BuscarUsuarioByIdDatasource _buscarUsuarioByIdDatasource;

  BuscarUsuarioByIdRepositoryImp(this._buscarUsuarioByIdDatasource);
  @override
  Future<Usuario?> call(String id, String token) {
    return _buscarUsuarioByIdDatasource(id, token);
  }
}

////////////////////////////////////////////////////////////////////////////////

class GetImageBackgroundRepositoryImp implements GetImageBackgroundRepository {
  final GetImageBackgroundDatasource _getImageBackgroundDatasource;

  GetImageBackgroundRepositoryImp(this._getImageBackgroundDatasource);
  @override
  Future<String> call() {
    return _getImageBackgroundDatasource();
  }
}
