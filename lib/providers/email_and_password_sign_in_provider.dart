import 'package:flutter/material.dart';
import 'package:divide_ai/validators/email_validator.dart'as email_validator;
import 'package:divide_ai/validators/password_validator.dart' as password_validator;

class EmailAndPasswordSignInProvider extends ChangeNotifier {
  String? _email;
  String? _password;

  bool _isEmailValid = false;
  bool _isPasswordValid = false;

  String? get email => _email;

  String? get password => _password;

  bool get isEmailValid => _isEmailValid;
  bool get isPasswordValid => _isPasswordValid;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  String? validateEmail(String? email) {
    String? validationMessage = email_validator.validateEmail(email);
    if (validationMessage == null) {
      _isEmailValid = true;
    } else {
      _isEmailValid = false;
    }
    notifyListeners();
    return validationMessage;
  }

  String? validatePassword(String? password) {
    String? validationMessage = password_validator.validatePassword(password);
    if (validationMessage == null) {
      _isPasswordValid = true;
    } else {
      _isPasswordValid = false;
    }
    notifyListeners();
    return validationMessage;
  }
}
