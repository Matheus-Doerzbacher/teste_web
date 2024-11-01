import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_web/modules/auth/auth_module.dart';
import 'package:teste_web/modules/auth/presentation/pages/home_page.dart';

class AppModule extends Module {
  @override
  void routes(r) {
    r.module('/', module: AuthModule());
    r.child('/home', child: (context) => const HomePage());
    super.routes(r);
  }
}
