import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartschool/home/setting-form.dart';
import 'package:smartschool/models/message.dart';
import 'package:smartschool/models/user.dart';
import 'package:smartschool/services/auth.dart';
import 'package:smartschool/services/database.dart';
import 'package:provider/provider.dart';
import 'message_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    void _showSettingsPanel() {
      showModalBottomSheet(
        isScrollControlled: true,
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    bool _isAdmin() {
      if (user.uid == "XFAHOg4HzLSKqXHunsB4S3AyF1n1") {
        return true;
      } else {
        return false;
      }
    }


    return StreamProvider<List<Message>>.value(
      value: DatabasesService().messages,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Home Page'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              color: Colors.black,
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              color: Colors.green,
              onPressed: () {
                if (_isAdmin()){
                  // TODO implement add note
                  print('Do Something');
                } else {
                  print('Not Admin');
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              color: Colors.grey,
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/crayon.png'),
              fit: BoxFit.cover,
            )
          ),
            child: MessageList()
        ),
      ),
    );
  }
}
