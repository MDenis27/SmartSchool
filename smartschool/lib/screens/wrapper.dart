import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartschool/home/home.dart';
import 'package:smartschool/models/user.dart';
import 'package:smartschool/screens/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  bool adminMode = false;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // Home or Authenticate
    if (user == null) {
      return Authenticate();
    } else {
      if(user.uid == "MerAG3gBNkdETxBqVsqezA54ENL2"){
        adminMode = true;
      }else{adminMode = false;}
      return HomePage(adminMode:adminMode , uid : user.uid);
    }
  }
}
