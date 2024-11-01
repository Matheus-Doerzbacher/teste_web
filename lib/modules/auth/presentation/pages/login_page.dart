import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teste_web/modules/auth/presentation/controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = TextEditingController();
  final _senhaController = TextEditingController();

  final controller = Modular.get<LoginController>();

  String? urlImage;

  @override
  void initState() {
    urlImage =
        'https://images.pexels.com/photos/147411/italy-mountains-dawn-daybreak-147411.jpeg';
    super.initState();
    // controller.getUrlImage().then((url) {
    //   if (mounted) {
    //     setState(() {
    //       urlImage = url;
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    _loginController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final result =
          await controller.login(_loginController.text, _senhaController.text);

      if (result) {
        _loginController.clear();
        _senhaController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        decoration: urlImage != null
            ? BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(urlImage ?? ''), fit: BoxFit.cover),
              )
            : null,
        child: Center(
            child: Container(
          width: 350,
          decoration: BoxDecoration(
              color: colorScheme.onPrimary.withOpacity(0.85),
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Entre na sua conta',
                  style: textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Utilize as infomações usadas no JACAD para acessar sua conta',
                  style: textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Image.asset(
                  'assets/images/logo-uniguacu.png',
                  width: 300,
                ),
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Login'),
                        controller: _loginController,
                        validator: (value) {
                          if (value == null || value == '') {
                            return 'Insira o seu login';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(labelText: 'Senha'),
                        controller: _senhaController,
                        validator: (value) {
                          if (value == null || value == '') {
                            return 'Insira a sua senha';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () {
                      _handleSubmit();
                    },
                    child: const Text('Entrar'),
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
