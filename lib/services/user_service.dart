import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divide_ai/helpers/snackbar_helper.dart';
import 'package:divide_ai/models/user.dart';

class UserService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<QueryDocumentSnapshot?> findUserByUsername(String username) async {
    QuerySnapshot userQuerySnapshot = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    bool userFound = userQuerySnapshot.size == 1;
    if (userFound) {
      return userQuerySnapshot.docs.first;
    } else {
      return null;
    }
  }

  Future<QueryDocumentSnapshot?> findUserByFirebaseUserUid(
    String firebaseUserUid,
  ) async {
    final userQuerySnapshot = await _firestore
        .collection('users')
        .where(
          'firebaseUserUid',
          isEqualTo: firebaseUserUid,
        )
        .get();

    bool userFound = userQuerySnapshot.size == 1;
    if (userFound) {
      return userQuerySnapshot.docs.first;
    } else {
      return null;
    }
  }

  Future<void> saveUser(User user) async {
    final firebaseUserUid = user.firebaseUser.uid;
    try {
      await _firestore
          .collection('users')
          .doc(firebaseUserUid)
          .set({'firebaseUserUid': firebaseUserUid, 'username': user.username});
    } catch (exception) {
      SnackbarHelper.showDefaultSnackbar(
        text: 'Falha ao salvar usuário.',
      );
    }
  }
}
