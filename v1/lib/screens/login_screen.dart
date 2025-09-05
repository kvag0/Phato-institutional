import 'package:flutter/cupertino.dart';
import 'package:phato_prototype/core/theme/app_theme.dart';
import 'package:phato_prototype/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controlador para os campos de texto
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    // Função de login mockada
    void performLogin() {
      Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    }

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Entrar'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 40),
                CupertinoTextField(
                  controller: emailController,
                  placeholder: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  padding: const EdgeInsets.all(16.0),
                ),
                const SizedBox(height: 16.0),
                CupertinoTextField(
                  controller: passwordController,
                  placeholder: 'Senha',
                  obscureText: true,
                  padding: const EdgeInsets.all(16.0),
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    onPressed: performLogin,
                    child: const Text('ENTRAR'),
                  ),
                ),
                const SizedBox(height: 24.0),
                // Divisor
                Row(
                  children: [
                    Expanded(
                        child: Container(height: 1, color: AppTheme.phatoGray)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('OU'),
                    ),
                    Expanded(
                        child: Container(height: 1, color: AppTheme.phatoGray)),
                  ],
                ),
                const SizedBox(height: 24.0),
                // Botão Google
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    color: AppTheme.phatoLightGray,
                    onPressed: performLogin,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Adicione o asset do logo do Google aqui quando tiver
                        // Image.asset('assets/google_logo.png', height: 20),
                        // const SizedBox(width: 10),
                        Text(
                          'Continuar com Google',
                          style: AppTheme.bodyTextStyle.copyWith(
                              color: AppTheme.phatoBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                // Botão Apple
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                    color: AppTheme.phatoLightGray,
                    onPressed: performLogin,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(CupertinoIcons.app,
                            color: AppTheme.phatoBlack),
                        const SizedBox(width: 10),
                        Text(
                          'Continuar com Apple',
                          style: AppTheme.bodyTextStyle.copyWith(
                              color: AppTheme.phatoBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
