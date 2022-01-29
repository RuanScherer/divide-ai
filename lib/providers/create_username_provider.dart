import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divide_ai/helpers/snackbar_helper.dart';
import 'package:divide_ai/providers/authentication_provider.dart';
import 'package:divide_ai/services/user_service.dart';
import 'package:flutter/material.dart.';

class CreateUsernameProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  final AuthenticationProvider? _authenticationProvider;

  String? _username;
  bool _isUsernameValid = false;

  CreateUsernameProvider(this._authenticationProvider);

  String? get username => _username;

  void setUsername(String newUsername) {
    _username = newUsername;
    notifyListeners();
  }

  String? validateUsername(String? username) {
    if (username == null || username.trim().isEmpty) {
      return 'É obrigatório informar uma tag de usuário.';
    } else if (username.trim().length < 4) {
      return 'A tag de usuário deve ter ao menos 4 dígitos.';
    } else if (username.contains('@')) {
      return 'A tag de usuário não pode conter @.';
    } else if (username.contains('\\')) {
      return 'A tag de usuário não pode conter \\.';
    }
    _isUsernameValid = true;
  }

  void handleRegisterUsername() {
    if (_isUsernameValid) {
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
    QueryDocumentSnapshot? userSnapshot =
        await _userService.findUserByUsername(_username!);

    return userSnapshot != null;
  }

  Future<void> _saveUsername() async {
    if (_authenticationProvider != null &&
        _authenticationProvider!.currentUser != null) {
      _authenticationProvider!.setUsername(_username!);
      await _userService.saveUser(_authenticationProvider!.currentUser!);
    } else {
      SnackbarHelper.showDefaultSnackbar(
        text: 'Falha ao obter usuário logado para criação da tag de usuário.',
      );
    }
  }
}
