import 'package:teste_web/modules/auth/domain/repositories/usuario_repository.dart';

abstract class GetImageBackgroundUsecase {
  Future<String> call();
}

class GetImageBackgroundUsecaseImp extends GetImageBackgroundUsecase {
  final GetImageBackgroundRepository _getImageBackgroundRepository;

  GetImageBackgroundUsecaseImp(this._getImageBackgroundRepository);
  @override
  Future<String> call() {
    return _getImageBackgroundRepository();
  }
}
