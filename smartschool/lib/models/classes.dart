import 'package:cloud_firestore/cloud_firestore.dart';

class Classes {
  final String id;
  final List messagesId;

  Classes(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        messagesId = snapshot.data['messagesId'];

  String toString() => "Class($id)<messageID: $messagesId>";
}