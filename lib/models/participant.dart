import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Participant {
  String? firebaseUserUid;
  String? avatarUrl;
  String? name;
  String? username;

  Participant();

  static fromQueryDocumentSnapshot(
    QueryDocumentSnapshot snapshot,
  ) {
    final dto = Participant();

    dto.firebaseUserUid = snapshot.get('firebaseUserUid');
    dto.avatarUrl = snapshot.get('avatarUrl');
    dto.name = snapshot.get('name');
    dto.username = snapshot.get('username');

    return dto;
  }

  static fromJSONString(String jsonString) {
    Map<String, dynamic> decodedJSON = json.decode(jsonString);
    final dto = Participant();

    dto.firebaseUserUid = decodedJSON['firebaseUserUid'];
    dto.avatarUrl = decodedJSON['avatarUrl'];
    dto.name = decodedJSON['name'];
    dto.username = decodedJSON['username'];

    return dto;
  }

  String toJSONString() {
    Map<String, dynamic> map = {
      'fireabseUserUid': firebaseUserUid,
      'avatarUrl': avatarUrl,
      'name': name,
      'username': username,
    };

    return json.encode(map);
  }
}
