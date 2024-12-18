import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_web/src/modules/auth/auth_module.dart';
import 'package:teste_web/src/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:teste_web/src/modules/auth/presentation/pages/home_page.dart';
import 'package:teste_web/src/modules/auth/presentation/pages/teste_admin.dart';
import 'package:teste_web/src/modules/auth/presentation/pages/teste_cobranca.dart';
import 'package:teste_web/src/modules/despesas/despesas_module.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    AuthModule().binds(i);
    DespesasModule().binds(i);
    super.binds(i);
  }

  @override
  void routes(r) {
    r.module('/login', module: AuthModule());
    r.module(
      '/despesas',
      module: DespesasModule(),
      guards: [AuthGuard()],
    );
    r.child(
      '/',
      child: (context) => const HomePage(),
      guards: [AuthGuard()],
      transition: TransitionType.leftToRightWithFade,
    );
    r.child(
      '/administrador/permissoes',
      child: (context) => const TesteAdmin(),
      guards: [AuthGuard()],
      transition: TransitionType.leftToRightWithFade,
    );
    r.child(
      '/cobranca/lista-distribuicao',
      child: (context) => const TesteCobranca(),
      guards: [AuthGuard()],
      transition: TransitionType.leftToRightWithFade,
    );
    super.routes(r);
  }
}

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/login/');

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final controller = Modular.get<AuthController>();

    if (!controller.isAuthenticated) {
      await controller.loadUserData();
    }

    return controller.isAuthenticated;
  }
}
