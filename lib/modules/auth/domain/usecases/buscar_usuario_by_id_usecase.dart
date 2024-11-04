import 'package:teste_web/modules/auth/domain/entities/usuario_entity.dart';
import 'package:teste_web/modules/auth/domain/repositories/usuario_repository.dart';

abstract class BuscarUsuarioByIdUsecase {
  Future<Usuario?> call(String id, String token);
}

class BuscarUsuarioByIdUsecaseImp implements BuscarUsuarioByIdUsecase {
  final BuscarUsuarioByIdRepository _buscarUsuarioByIdRepository;

  BuscarUsuarioByIdUsecaseImp(this._buscarUsuarioByIdRepository);

  @override
  Future<Usuario?> call(String id, String token) {
    return _buscarUsuarioByIdRepository(id, token);
  }
}
