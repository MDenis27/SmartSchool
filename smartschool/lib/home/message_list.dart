import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartschool/home/message_tile.dart';
import 'package:smartschool/models/message.dart';

class MessageList extends StatefulWidget {
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {

    final messages = Provider.of<List<Message>>(context);

    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return MessageTile(message: messages[index]);
      },
    );
  }
}
