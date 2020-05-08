import 'package:cloud_firestore/cloud_firestore.dart';

class Classes {
  final String id;
  final List noticesId;

  Classes(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        noticesId = snapshot.data['noticesId'];

  String toString() => "Class($id)<noticesId: $noticesId>";
}