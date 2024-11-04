import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_web/modules/auth/data/datasources/api/buscar_usuario_by_id_datasource_imp.dart';
import 'package:teste_web/modules/auth/data/datasources/api/login_usuario_api_datasource_imp.dart';
import 'package:teste_web/modules/auth/data/datasources/usuario_datasource.dart';
import 'package:teste_web/modules/auth/data/repositories_imp/usuario_repository_imp.dart';
import 'package:teste_web/modules/auth/domain/repositories/usuario_repository.dart';
import 'package:teste_web/modules/auth/domain/usecases/buscar_usuario_by_id_usecase.dart';
import 'package:teste_web/modules/auth/domain/usecases/login_usuario_usecase.dart';
import 'package:teste_web/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:teste_web/modules/auth/presentation/controllers/login_controller.dart';
import 'package:teste_web/modules/auth/presentation/pages/login_page.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    // DATASOURCE
    i.addLazySingleton<LoginUsuarioDatasource>(
      LoginUsuarioApiDatasourceImp.new,
    );
    i.addLazySingleton<BuscarUsuarioByIdDatasource>(
      BuscarUsuarioByIdDatasourceImp.new,
    );

    // REPOSITORY
    i.addLazySingleton<LoginUsuarioRepository>(
      () => LoginUsuarioRepositoryImp(i()),
    );
    i.addLazySingleton<BuscarUsuarioByIdRepository>(
      () => BuscarUsuarioByIdRepositoryImp(i()),
    );

    // USECASE
    i.addLazySingleton<LoginUsuarioUsecase>(
      () => LoginUsuarioUsecaseImp(i()),
    );
    i.addLazySingleton<BuscarUsuarioByIdUsecase>(
      () => BuscarUsuarioByIdUsecaseImp(i()),
    );

    // CONTROLLERS
    i.addLazySingleton<AuthController>(
      AuthController.new,
    );

    i.addLazySingleton<LoginController>(
      () => LoginController(
        i(),
        i(),
      ),
    );
    super.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (context) => const LoginPage(),
      guards: [LoginAuthGuard()],
    );
    super.routes(r);
  }
}

class LoginAuthGuard extends RouteGuard {
  LoginAuthGuard() : super(redirectTo: '/');

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final controller = Modular.get<AuthController>();

    if (!controller.isAuthenticated) {
      await controller.loadUserData();
    }

    return !controller.isAuthenticated;
  }
}
