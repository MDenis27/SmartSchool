import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:smartschool/services/auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AddMessagePage extends StatefulWidget {
  _AddMessagePageState createState() => _AddMessagePageState();
}

class _AddMessagePageState extends State<AddMessagePage> {
  final _formKey = GlobalKey<FormState>();
  final _objectController = TextEditingController();
  final _textController = TextEditingController();
  final AuthService _auth = AuthService();

  List<int> checkedClasses = [];
  bool checkBoxValue = false;
  DateTime _date = DateTime.now();

  @override
  void dispose() {
    _objectController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.lightGreenAccent[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.exit_to_app),
              label: Text('Logout'),
              onPressed:() async {
                await _auth.signOut();
              }
          )
        ],
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text('Ajouter un message'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _objectController,
                      decoration: const InputDecoration(
                        labelText: 'Titre',
                        hintText: 'Titre',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Veuillez entrer un titre';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _textController,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText: 'Text',
                        hintText: 'Message',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Veuillez entrer un message';
                        }
                        return null;
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text("Choisir une classe",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0
                        ),
                      ),
                    ),

                    CheckboxGroup(
                      orientation: GroupedButtonsOrientation.HORIZONTAL,
                      padding: const EdgeInsets.only(left: 14.0, top: 24.0,right:14),
                      labels: <String>[
                        "1A",
                        "2A",
                        "3A",
                        "4A",
                        "5A",
                        "6A",
                      ],
                      onChange: (bool isChecked, String label, int index){
                        if(isChecked){
                          checkedClasses.add(index);
                        }else{
                          checkedClasses.remove(index);
                        }
                        print(checkedClasses);
                      }, //=> print("isChecked: $isChecked   label: $label  index: $index"),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Annuler"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      var message = {
                        'title':  _objectController.text,
                        'text': _textController.text,
                        'date': _date,
                      };

                      if (_formKey.currentState.validate()) {
                        DatabaseReference databaseReference = new FirebaseDatabase().reference();
                        for(var i in checkedClasses){
                          Firestore.instance
                              .collection('classes').document(i.toString()).collection('messages').add(message);
                          databaseReference.child('notification/' + (i+1).toString()).set(DateTime.now().toString());
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Ajouter"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
