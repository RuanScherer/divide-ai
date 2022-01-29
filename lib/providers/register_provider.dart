import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  String? _email;
  String? _password;

  bool _isEmailValid = false;
  bool _isPasswordValid = false;

  String? get email => _email;

  String? get password => _password;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'É obrigatório informar um endereço de e-mail.';
    } else if (!email.contains('@') ||
        !email.contains('.') ||
        email.trim().length < 5) {
      return 'Endereço de e-mail inválido.';
    } else if (email.contains('\\')) {
      return 'O endereço de e-mail não pode conter \\.';
    }
    _isEmailValid = true;
  }

  String? validatePassword(String? password) {
    if (password == null || password.trim().isEmpty) {
      return 'É obrigatório informar a senha.';
    } else if (password.trim().length < 8) {
      return 'Senha muito curta (deve ter no mínimo 8 caracteres).';
    }
    _isPasswordValid = true;
  }
}
