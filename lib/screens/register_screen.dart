import 'package:divide_ai/providers/authentication_provider.dart';
import 'package:divide_ai/providers/register_provider.dart';
import 'package:divide_ai/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiProvider(
          providers: [
            ListenableProvider<RegisterProvider>(
              create: (_) => RegisterProvider(),
            ),
            ListenableProvider<AuthenticationProvider>(
              create: (_) => AuthenticationProvider(),
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Form(
                      key: _formKey,
                      child: Consumer<RegisterProvider>(
                        builder: (context, registerProvider, child) => Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Cadastre-se no',
                              style: TextStyle(fontSize: 30),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              'Divide Aí',
                              style: TextStyle(
                                fontSize: 30,
                                height: 1.3,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            DefaultTextFormField(
                              validator: registerProvider.validateEmail,
                              onChanged: (text) {
                                _formKey.currentState?.validate();
                                registerProvider.setEmail(text);
                              },
                              keyboardType: TextInputType.emailAddress,
                              labelText: 'E-mail',
                              value: registerProvider.email ?? '',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            DefaultTextFormField(
                              validator: registerProvider.validatePassword,
                              onChanged: (text) {
                                _formKey.currentState?.validate();
                                registerProvider.setPassword(text);
                              },
                              obscureText: true,
                              labelText: 'Senha',
                              value: registerProvider.password ?? '',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            DefaultTextFormField(
                              validator:
                                  registerProvider.validatePasswordConfirmation,
                              onChanged: (text) {
                                _formKey.currentState?.validate();
                                registerProvider.setPasswordConfirmation(text);
                              },
                              obscureText: true,
                              labelText: 'Confirmar senha',
                              value:
                                  registerProvider.passwordConfirmation ?? '',
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: Colors.grey[300]!,
                      width: 2,
                    ),
                  ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 15,
                            ),
                            child: Text(
                              'VOLTAR',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 2,
                        color: Colors.grey[300],
                      ),
                      Expanded(
                        flex: 1,
                        child:
                            Consumer2<RegisterProvider, AuthenticationProvider>(
                          builder: (
                            context,
                            registerProvider,
                            authenticationProvider,
                            child,
                          ) {
                            return InkWell(
                              onTap: () {
                                if (registerProvider.isFormValid) {
                                  Provider.of<AuthenticationProvider>(
                                    context,
                                    listen: false,
                                  ).createUserWithEmailAndPassword(
                                    registerProvider.email!,
                                    registerProvider.password!,
                                  );
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 15,
                                ),
                                child: Text(
                                  'CONTINUAR',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
