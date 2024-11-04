import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:teste_web/core/app_module.dart';
import 'package:teste_web/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:teste_web/modules/auth/presentation/controllers/login_controller.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();

  runApp(
    ModularApp(
      module: AppModule(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Modular.get<LoginController>(),
          ),
          ChangeNotifierProvider(
            create: (context) => Modular.get<AuthController>(),
          )
        ],
        child: const AppWidget(),
      ),
    ),
  );
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final authController = GetIt.I<AuthController>();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Intranet Uniguaçu',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF004a97),
        ).copyWith(
          primary: const Color(0xFF004a97),
        ),
        useMaterial3: true,
      ),
      routerConfig: Modular.routerConfig,
    );
  }
}
