import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class User {
  firebase_auth.User firebaseUser;
  String? name;
  String? username;

  User({
    this.name,
    this.username,
    required this.firebaseUser,
  });
}
