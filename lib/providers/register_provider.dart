import 'package:flutter/material.dart';
import 'package:divide_ai/validators/email_validator.dart' as email_validator;
import 'package:divide_ai/validators/password_validator.dart'
    as password_validator;

class RegisterProvider extends ChangeNotifier {
  String? _email;
  String? _password;
  String? _passwordConfirmation;

  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isPasswordConfirmationValid = false;

  String? get email => _email;

  String? get password => _password;

  String? get passwordConfirmation => _passwordConfirmation;

  bool get isEmailValid => _isEmailValid;

  bool get isPasswordValid => _isPasswordValid;

  bool get isPasswordConfirmationValid => _isPasswordConfirmationValid;

  bool get isFormValid =>
      _isEmailValid &&
      _isPasswordValid &&
      _isPasswordConfirmationValid;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setPasswordConfirmation(String passwordConfirmation) {
    _passwordConfirmation = passwordConfirmation;
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

  String? validatePasswordConfirmation(String? passwordConfirmation) {
    String? validationMessage = password_validator.validatePasswordConfirmation(
      password,
      passwordConfirmation,
    );
    if (validationMessage == null) {
      _isPasswordConfirmationValid = true;
    } else {
      _isPasswordConfirmationValid = false;
    }
    notifyListeners();
    return validationMessage;
  }
}
