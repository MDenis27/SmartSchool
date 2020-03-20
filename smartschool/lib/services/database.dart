import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartschool/models/message.dart';

class DatabasesService {
  final String uid;
  DatabasesService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  final CollectionReference messageCollection =
      Firestore.instance.collection('messages');

  Future updateUserData(
      String name, String firstname, String phone, String email) async {
    return await userCollection.document(uid).setData(
        {'name': name, 'firstname': firstname, 'phone': phone, 'email': email, 'classes': '0'});
  }

  // message list from snapshot
  List<Message> _messageListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Message(
        title: doc.data['title'] ?? '',
        classes: doc.data['classes'] ?? [],
        text: doc.data['text'] ?? '',
      );
    }).toList();
  }

  // get users streams
  Stream<List<Message>> get messages {
    return messageCollection.snapshots()
    .map(_messageListFromSnapshot);
  }
}
