import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String title;
  final String text;
  final DateTime date;

  Message(DocumentSnapshot snapshot)
      : id = snapshot.documentID,
        title = snapshot.data['object'],
        text = snapshot.data['text'],
        date = snapshot.data['date'].toDate();

  String get formatedDate => "${date.day}/${date.month}/${date.year}";

  String toString() => "Notice($id)<objet: $title, date: $formatedDate, text : $text>";
}