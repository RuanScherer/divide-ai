import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class User {
  firebase_auth.User firebaseUser;
  String? username;

  User({
    this.username,
    required this.firebaseUser,
  });
}
