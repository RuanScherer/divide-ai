import 'package:divide_ai/globals/globals.dart';
import 'package:divide_ai/helpers/snackbar_helper.dart';
import 'package:divide_ai/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:divide_ai/models/user.dart' as divide_ai_user;

class AuthenticationProvider extends ChangeNotifier {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();

  divide_ai_user.User? _currentUser;

  divide_ai_user.User? get currentUser => _currentUser;

  AuthenticationProvider() {
    _auth.authStateChanges().listen(validateAuthentication);
  }

  void setName(String name) {
    if (_currentUser != null) {
      _currentUser!.name = name;
      notifyListeners();
    }
  }

  void setUsername(String username) {
    if (_currentUser != null) {
      _currentUser!.username = username;
      notifyListeners();
    }
  }

  Future<void> validateAuthentication(User? user) async {
    if (user != null) {
      final storedUser = await _userService.findUserByFirebaseUserUid(user.uid);
      _currentUser = divide_ai_user.User(
        firebaseUser: user,
        name: storedUser?.name,
        username: storedUser?.username,
      );
    } else {
      _currentUser = null;
    }
    notifyListeners();
  }

  void signInWithGoogle() async {
    // trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // obtain the auth details from the request
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleUser?.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      await _auth.signInWithCredential(credentials);
    } catch (exception) {
      snackbarKey.currentState?.showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueAccent,
          content: Text('Falha ao logar com Google.'),
        ),
      );
    }
  }

  void signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      navigatorKey.currentState?.pop();
    } on FirebaseAuthException catch (exception) {
      if (exception.code == 'user-not-found') {
        SnackbarHelper.showDefaultSnackbar(text: 'Usu??rio n??o encontrado.');
      } else {
        SnackbarHelper.showDefaultSnackbar(
          text: 'Dados inv??lidos, tente novamente.',
        );
      }
    } catch(exception) {
      SnackbarHelper.showDefaultSnackbar(
        text: 'Falha ao entrar no Divide A??, tente novamente.',
      );
    }
  }

  void signOut() async {
    await _auth.signOut();
    _currentUser = null;
    notifyListeners();
  }

  void createUserWithEmailAndPassword(String email, String password) async {
    try {
      SnackbarHelper.showDefaultSnackbar(text: 'Cadastrando usu??rio...');
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      SnackbarHelper.dismissCurrentSnackbar();
      SnackbarHelper.showDefaultSnackbar(
        text: 'Usu??rio cadastrado com sucesso!',
      );
      navigatorKey.currentState?.pop();
    } on FirebaseAuthException catch (exception) {
      late String errorMessage;
      switch (exception.code) {
        case 'weak-password':
          errorMessage = 'A senha informada ?? muito fraca.';
          break;
        case 'email-already-in-use':
          errorMessage = 'J?? existe uma conta para esse endere??o de e-mail.';
          break;
        case 'invalid-email':
          errorMessage = 'O endere??o de e-mail informado ?? inv??lido.';
          break;
        default:
          errorMessage = 'Falha ao cadastrar usu??rio, tente novamente.';
          break;
      }

      SnackbarHelper.showDefaultSnackbar(text: errorMessage);
    } catch (exception) {
      SnackbarHelper.showDefaultSnackbar(
        text: 'Falha ao cadastrar usu??rio, tente novamente.',
      );
    }
  }
}
