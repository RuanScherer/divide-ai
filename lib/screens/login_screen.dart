import 'package:divide_ai/providers/authentication_provider.dart';
import 'package:divide_ai/screens/register_screen.dart';
import 'package:divide_ai/widgets/default_button.dart';
import 'package:divide_ai/widgets/named_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'email_and_password_sign_in_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).primaryColor,
      ),
      child: Scaffold(
        body: SafeArea(
          child: PageView(
            scrollDirection: Axis.vertical,
            children: [
              _buildWelcomePage(context),
              _buildLoginPage(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomePage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 36),
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Text(
                'Divida contas com\nseus amigos',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                'Simples, rápido, fácil.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Expanded(
            child: SvgPicture.asset(
              'assets/images/friends_online_connection.svg',
            ),
          ),
          Column(
            children: const [
              Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
                size: 36,
              ),
              Text(
                'Começe agora deslizando',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLoginPage(BuildContext context) {
    final AuthenticationProvider authenticationProvider = Provider.of<AuthenticationProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Faça seu login',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'com uma das opções abaixo',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DefaultButton(
                text: 'Entrar com e-mail',
                leading: const Icon(
                  Icons.email_outlined,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EmailAndPasswordSignInScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DefaultButton(
                text: 'Entrar com Google',
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                backgroundColor: Colors.blueAccent,
                overlayColor: Colors.white30,
                leading: const FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                  size: 22,
                ),
                onPressed: authenticationProvider.signInWithGoogle,
              ),
              Container(
                margin: const EdgeInsets.only(top: 6, left: 4, right: 4),
                child: Text(
                  'Não é necessário ter uma conta no Divide Aí para entrar com o Google.',
                  style: TextStyle(
                    color: Colors.grey[600],
                    height: 1.1,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const NamedDivider(text: 'ou',),
              const SizedBox(
                height: 16,
              ),
              DefaultButton(
                text: 'Cadastre-se',
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                trailing: const FaIcon(
                  FontAwesomeIcons.arrowRight,
                  color: Colors.white,
                  size: 20,
                ),
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.9),
                overlayColor: Colors.white30,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
