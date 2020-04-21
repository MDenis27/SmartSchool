import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartschool/home/message_tile.dart';
import 'package:smartschool/models/message.dart';
import 'package:smartschool/models/user.dart';
import 'package:smartschool/services/database.dart';

class MessageList extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    // u is a stream
    var u = DatabasesService(uid: user.uid).userData;
    final messages = Provider.of<List<Message>>(context) ?? [];
    var userMessages = [];
    for (Message message in messages){
      var classes = [];
    }

    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return MessageTile(message: messages[index]);
      },
    );
  }
}
