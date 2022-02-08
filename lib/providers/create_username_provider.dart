import 'package:divide_ai/helpers/snackbar_helper.dart';
import 'package:divide_ai/models/participant.dart';
import 'package:divide_ai/providers/authentication_provider.dart';
import 'package:divide_ai/services/user_service.dart';
import 'package:flutter/material.dart.';
import 'package:divide_ai/validators/name_validator.dart' as name_validator;
import 'package:divide_ai/validators/username_validator.dart'
    as username_validator;

class CreateUsernameProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  final AuthenticationProvider? _authenticationProvider;

  String? _name;
  String? _username;

  bool _isNameValid = false;
  bool _isUsernameValid = false;

  CreateUsernameProvider(this._authenticationProvider) {
    if (_authenticationProvider != null) {
      setNameFromFirebaseUser();
    }
  }

  String? get name => _name;

  String? get username => _username;

  bool get isFormValid => _isNameValid && _isUsernameValid;

  void setNameFromFirebaseUser() {
    final firebaseUserDisplayName =
        _authenticationProvider?.currentUser!.firebaseUser.displayName;
    if (firebaseUserDisplayName != null) {
      setName(firebaseUserDisplayName);
    }
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setUsername(String newUsername) {
    _username = newUsername;
    notifyListeners();
  }

  String? validateName(String? name) {
    String? validationMessage = name_validator.validateName(name);
    if (validationMessage == null) {
      _isNameValid = true;
    } else {
      _isNameValid = false;
    }
    notifyListeners();
    return validationMessage;
  }

  String? validateUsername(String? username) {
    String? validationMessage = username_validator.validateUsername(username);
    if (validationMessage == null) {
      _isUsernameValid = true;
    } else {
      _isUsernameValid = false;
    }
    notifyListeners();
    return validationMessage;
  }

  void handleRegisterUsername() {
    if (isFormValid) {
      _registerUsername();
    }
  }

  void _registerUsername() async {
    if (await isUsersnameAlreadyInUse()) {
      SnackbarHelper.showDefaultSnackbar(
        text: 'Tag de usuário já utilizada por outro usuário.',
      );
    } else {
      await _saveUsername();
    }
  }

  Future<bool> isUsersnameAlreadyInUse() async {
    Participant? userSnapshot =
        await _userService.findUserByUsername(_username!);

    return userSnapshot != null;
  }

  Future<void> _saveUsername() async {
    if (_authenticationProvider != null &&
        _authenticationProvider!.currentUser != null) {
      _authenticationProvider!.setName(_name!);
      _authenticationProvider!.setUsername(_username!);
      await _userService.saveUser(_authenticationProvider!.currentUser!);
    } else {
      SnackbarHelper.showDefaultSnackbar(
        text: 'Falha ao obter usuário logado para criação da tag de usuário.',
      );
    }
  }
}
