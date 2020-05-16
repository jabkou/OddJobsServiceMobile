import 'package:flutter/material.dart';
import 'package:flutterappservice/models/user.dart';
import 'package:flutterappservice/widgets/navbar.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatelessWidget {
  User user;
  @override
  Widget build(BuildContext context) {
    this.user = Provider.of<User>(context);
    String imie, nazwisko, email, numer, user;
    try{
      user = this.user.getUserName();
      imie = this.user.getFirstName();
      nazwisko = this.user.getLastName();
      email = this.user.getEmail();
      numer = this.user.getPhoneNumber();
    } on Exception catch(e){
      user = "this.user.getUserName()";
      imie = "this.user.getFirstName()";
      nazwisko = "this.user.getLastName()";
      email = "this.user.getEmail()";
      numer = "this.user.getPhoneNumber()";
      print(e.toString());
      print(this.user.isBlocked());
      print(this.user.isLogin());
    }


    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomPadding: false,
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(100.0, 0.0, 100.0, 150.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            user,
          ),
          Text(
            imie,
          ),
          Text(
            nazwisko,
          ),
          Text(
            email,
          ),
          Text(
            numer,
          ),
        ]),
      ),
    );
  }
}
