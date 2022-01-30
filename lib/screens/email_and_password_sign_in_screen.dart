import 'package:divide_ai/providers/authentication_provider.dart';
import 'package:divide_ai/providers/email_and_password_sign_in_provider.dart';
import 'package:divide_ai/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailAndPasswordSignInScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  EmailAndPasswordSignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiProvider(
          providers: [
            ListenableProvider<EmailAndPasswordSignInProvider>(
              create: (_) => EmailAndPasswordSignInProvider(),
            ),
            ListenableProvider<AuthenticationProvider>(
              create: (_) => AuthenticationProvider(),
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(22),
                child: Form(
                  key: _formKey,
                  child: Consumer<EmailAndPasswordSignInProvider>(
                    builder: (context, emailAndPasswordSignInProvider, child) =>
                        Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Entre no',
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
                          height: 30,
                        ),
                        DefaultTextFormField(
                          validator:
                              emailAndPasswordSignInProvider.validateEmail,
                          onChanged: (text) {
                            _formKey.currentState?.validate();
                            emailAndPasswordSignInProvider.setEmail(text);
                          },
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'E-mail',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DefaultTextFormField(
                          validator: emailAndPasswordSignInProvider.validatePassword,
                          onChanged: (text) {
                            _formKey.currentState?.validate();
                            emailAndPasswordSignInProvider.setPassword(text);
                          },
                          autofocus: false,
                          obscureText: true,
                          hintText: 'Senha',
                        ),
                      ],
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
                        child: Consumer2<EmailAndPasswordSignInProvider,
                            AuthenticationProvider>(
                            builder: (context, emailAndPasswordSignInProvider,
                                authenticationProvider, child) {
                              return InkWell(
                                onTap: () {
                                  if (emailAndPasswordSignInProvider.isEmailValid &&
                                      emailAndPasswordSignInProvider.isPasswordValid) {
                                    Provider.of<AuthenticationProvider>(
                                      context,
                                      listen: false,
                                    ).signInWithEmailAndPassword(
                                      emailAndPasswordSignInProvider.email!,
                                      emailAndPasswordSignInProvider.password!,
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
                            }
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
