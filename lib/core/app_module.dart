import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_web/modules/auth/auth_module.dart';
import 'package:teste_web/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:teste_web/modules/auth/presentation/pages/home_page.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    AuthModule().binds(i);
    super.binds(i);
  }

  @override
  void routes(r) {
    r.module('/login/', module: AuthModule());
    r.child('/', child: (context) => const HomePage(), guards: [AuthGuard()]);
    super.routes(r);
  }
}

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/login');

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final controller = Modular.get<AuthController>();

    if (!controller.isAuthenticated) {
      await controller.loadUserData();
    }

    return controller.isAuthenticated;
  }
}
