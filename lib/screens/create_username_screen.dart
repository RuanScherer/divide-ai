import 'package:divide_ai/providers/authentication_provider.dart';
import 'package:divide_ai/providers/create_username_provider.dart';
import 'package:divide_ai/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateUsernameScreen extends StatefulWidget {
  const CreateUsernameScreen({Key? key}) : super(key: key);

  @override
  _CreateUsernameScreenState createState() => _CreateUsernameScreenState();
}

class _CreateUsernameScreenState extends State<CreateUsernameScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<AuthenticationProvider,
        CreateUsernameProvider>(
      create: (_) => CreateUsernameProvider(null),
      update: (context, authenticationProvider, createUsernameProvider) =>
          CreateUsernameProvider(authenticationProvider),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Qual será sua',
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      'tag de usuário?',
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
                    Consumer<CreateUsernameProvider>(
                      builder: (context, createUsernameProvider, child) => Form(
                        key: _formKey,
                        child: DefaultTextFormField(
                          validator: createUsernameProvider.validateUsername,
                          onChanged: (text) {
                            _formKey.currentState?.validate();
                            createUsernameProvider.setUsername(text);
                          },
                          hintText: 'Ex.: joao_vitor12',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Seus amigos poderão te encontrar facilmente por essa tag. Ah, e pra isso ela precisa ser única ;)',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
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
                child: Consumer<CreateUsernameProvider>(
                  builder: (context, createUsernameProvider, child) => InkWell(
                    onTap: createUsernameProvider.handleRegisterUsername,
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
