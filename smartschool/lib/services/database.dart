import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartschool/models/message.dart';
import 'package:smartschool/models/user.dart';

class DatabasesService {
  final String uid;
  DatabasesService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  final CollectionReference messageCollection =
      Firestore.instance.collection('messages');

  Future updateUserData(
      String name, String firstname, String phone, String email, String classe) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'firstname': firstname,
      'phone': phone,
      'email': email,
      'classe': classe
    });
  }

  // message list from snapshot
  List<Message> _messageListFromSnapshot(QuerySnapshot snapshot) {
    List<Message> messages = snapshot.documents.map((doc) {
      return Message(
        title: doc.data['title'] ?? '',
        classes: doc.data['classes'] ?? [],
        text: doc.data['text'] ?? '',
      );
    }).toList();
    return messages;
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      firstname: snapshot.data['firstname'],
      mail: snapshot.data['mail'],
      phone: snapshot.data['phone'],
      classes: snapshot.data['classes'],
    );
  }

  // get users streams
  Stream<List<Message>> get messages {
    return messageCollection.snapshots().map(_messageListFromSnapshot);
  }

  // get user doc streams
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots()
        .map((_userDataFromSnapshot));
  }

}
