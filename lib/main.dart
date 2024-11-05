import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';
import 'package:teste_web/core/app_module.dart';
import 'package:teste_web/core/theme/theme_data_custom.dart';
import 'package:teste_web/modules/auth/presentation/controllers/auth_controller.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();

  runApp(
    ModularApp(
      module: AppModule(),
      child: MultiProvider(
        providers: [
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
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Intranet Uniguaçu',
      theme: ThemeDataCustom().light(),
      darkTheme: ThemeDataCustom().dark(),
      routerConfig: Modular.routerConfig,
      themeMode: ThemeMode.light,
    );
  }
}
