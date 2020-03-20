import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartschool/models/message.dart';
import 'package:smartschool/services/auth.dart';
import 'package:smartschool/services/database.dart';
import 'package:provider/provider.dart';
import 'message_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Message>>.value(
      value: DatabasesService().messages,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Home Page'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                }, icon: Icon(Icons.person), label: Text("logout"))
          ],
        ),
        body: MessageList(),
      ),
    );
  }
}
