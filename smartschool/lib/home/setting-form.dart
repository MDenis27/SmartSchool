import 'package:flutter/material.dart';
import 'package:smartschool/shared/constants.dart';

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
  String _currentClasses;
  String _currentName;
  String _currentFirstname;
  String _currentPhone;

  @override
  Widget build(BuildContext context) {
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
              decoration: textInputDecoration.copyWith(hintText: 'Name'),
              validator: (val) => val.isEmpty ? 'Please enter a name' : null,
              onChanged: (val) {
                setState(() => _currentName = val);
              }),
          SizedBox(height: 20.0),
          TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Firstname'),
              validator: (val) =>
                  val.isEmpty ? 'Please enter a firstname' : null,
              onChanged: (val) {
                setState(() => _currentFirstname = val);
              }),
          SizedBox(height: 20.0),
          TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Phone'),
              validator: (val) =>
              val.isEmpty ? 'Please enter a phone number' : null,
              onChanged: (val) {
                setState(() => _currentPhone = val);
              }),
          SizedBox(height: 20.0),
          // dropdown
          DropdownButtonFormField(
            decoration: textInputDecoration.copyWith(hintText: 'Class'),
            items: classes.map((classe){
              return DropdownMenuItem(
                value: classe,
                child: Text('$classe class'),
              );
            }).toList(),
            onChanged: (val) => setState(() => _currentClasses = val),
          ),
          RaisedButton(
            color: Colors.pink[400],
            child: Text(
              'Update',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              print(_currentName);
              print(_currentFirstname);
              print(_currentClasses);
              print(_currentPhone);
            },
          )
        ],
      ),
    );
  }
}
