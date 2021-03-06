import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:divide_ai/helpers/snackbar_helper.dart';
import 'package:divide_ai/models/participant.dart';
import 'package:divide_ai/models/user.dart';

class UserService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Participant>?> findUserByNameOrUsername(
    String nameOrUsername,
  ) async {
    QuerySnapshot nameQuerySnapshot = await _firestore
        .collection('users')
        .where('name', isEqualTo: nameOrUsername)
        .get();

    QuerySnapshot usernameQuerySnapshot = await _firestore
        .collection('users')
        .where('username', isEqualTo: nameOrUsername)
        .get();

    bool userFound =
        nameQuerySnapshot.size >= 1 || usernameQuerySnapshot.size >= 1;
    if (userFound) {
      return [
        ...nameQuerySnapshot.docs
            .map((e) => Participant.fromQueryDocumentSnapshot(e)),
        ...usernameQuerySnapshot.docs
            .map((e) => Participant.fromQueryDocumentSnapshot(e)),
      ];
    } else {
      return null;
    }
  }

  Future<Participant?> findUserByUsername(String username) async {
    QuerySnapshot userQuerySnapshot = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    bool userFound = userQuerySnapshot.size == 1;
    if (userFound) {
      return Participant.fromQueryDocumentSnapshot(
        userQuerySnapshot.docs.first,
      );
    } else {
      return null;
    }
  }

  Future<Participant?> findUserByFirebaseUserUid(
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
      return Participant.fromQueryDocumentSnapshot(
        userQuerySnapshot.docs.first,
      );
    } else {
      return null;
    }
  }

  Future<void> saveUser(User user) async {
    final firebaseUserUid = user.firebaseUser.uid;
    try {
      await _firestore.collection('users').doc(firebaseUserUid).set({
        'firebaseUserUid': firebaseUserUid,
        'avatarUrl': user.firebaseUser.photoURL,
        'name': user.name,
        'username': user.username,
      });
    } catch (exception) {
      SnackbarHelper.showDefaultSnackbar(
        text: 'Falha ao salvar usu??rio.',
      );
    }
  }
}
