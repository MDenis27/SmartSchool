import 'package:flutter/material.dart';
import 'package:smartschool/models/message.dart';

class MessageTile extends StatelessWidget {
  final Message message;
  MessageTile({this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: FlutterLogo(),
          title: Text(message.title),
          subtitle: Text(message.text),
          trailing: Icon(Icons.more_vert),
          isThreeLine: true,
        ),
      ),
    );
  }
}
