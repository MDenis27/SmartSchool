import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartschool/models/user.dart';
import 'package:smartschool/services/database.dart';
import 'package:smartschool/shared/constants.dart';
import 'package:smartschool/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> classes = [
    '1A',
    '1B',
    '2A',
    '2B',
    '3A',
    '3B',
    '4A',
    '4B',
    '5A',
    '5B',
    '6A',
    '6B'
  ];

  // form values
  String _currentClasse;
  String _currentName;
  String _currentFirstname;
  String _currentPhone;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabasesService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      initialValue: userData.name,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Name'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) {
                        setState(() => _currentName = val);
                      }),
                  SizedBox(height: 20.0),
                  TextFormField(
                      initialValue: userData.firstname,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Firstname'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a firstname' : null,
                      onChanged: (val) {
                        setState(() => _currentFirstname = val);
                      }),
                  SizedBox(height: 20.0),
                  TextFormField(
                      initialValue: userData.phone,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Phone'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a phone number' : null,
                      onChanged: (val) {
                        setState(() => _currentPhone = val);
                      }),
                  SizedBox(height: 20.0),
                  // dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Class'),
                    value: _currentClasse ?? userData.classe,
                    items: classes.map((classe) {
                      return DropdownMenuItem(
                        value: classe,
                        child: Text('$classe class'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentClasse = val),
                  ),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabasesService(uid: user.uid).updateUserData(
                            _currentName ?? userData.name,
                            _currentFirstname ?? userData.firstname,
                            _currentPhone ?? userData.phone,
                            userData.mail,
                            _currentClasse ?? userData.classe);
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
