class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String mail;
  final String name;
  final String firstname;
  final String phone;
  final Map classes;

  UserData(
      {this.uid,
      this.phone,
      this.firstname,
      this.mail,
      this.name,
      this.classes});
}
