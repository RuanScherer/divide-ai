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
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(22),
                    child: Form(
                      key: _formKey,
                      child: Consumer<CreateUsernameProvider>(
                        builder: (context, createUsernameProvider, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Como os outros',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Text(
                                'irão te ver?',
                                style: TextStyle(
                                  fontSize: 30,
                                  height: 1.3,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              DefaultTextFormField(
                                validator: createUsernameProvider.validateName,
                                onChanged: (text) {
                                  createUsernameProvider.setName(text);
                                  _formKey.currentState?.validate();
                                },
                                textCapitalization: TextCapitalization.words,
                                labelText: 'Nome',
                                value: createUsernameProvider.name ?? '',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              DefaultTextFormField(
                                validator: createUsernameProvider.validateUsername,
                                onChanged: (text) {
                                  createUsernameProvider.setUsername(text);
                                  _formKey.currentState?.validate();
                                },
                                labelText: 'Tag de usuário',
                                hintText: 'Ex.: joao_vitor12',
                                value: createUsernameProvider.username ?? '',
                              ),
                              const SizedBox(
                                height: 10,
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
                          );
                        },
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
