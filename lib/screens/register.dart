import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterappservice/common/constants.dart';
import 'package:flutterappservice/screens/first.dart';
import 'package:flutterappservice/screens/login.dart';
import 'package:flutterappservice/widgets/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';
import '../widgets/alertbox.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _username = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _confirmPassword = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _firstName = new TextEditingController();
  final TextEditingController _lastName = new TextEditingController();
  final TextEditingController _phoneNumber = new TextEditingController();
  bool succRegister = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/bck.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Color.fromRGBO(255, 255, 255, 0.5), BlendMode.modulate),
          ),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(80.0, 30.0, 80.0, 100.0),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Register:',
                    style: Theme.of(context).textTheme.display4,
                  ),
                  _registerFormField(_username, 'Login'),
                  _registerFormField(_password, 'Password', obscureText: true),
                  _registerFormField(_confirmPassword, 'Confirm Password',
                      obscureText: true),
                  _registerFormField(_firstName, 'Name'),
                  _registerFormField(_lastName, 'Surname'),
                  _registerFormField(_email, 'e-mail'),
                  _registerFormField(_phoneNumber, 'phone number'),
                  SizedBox(
                    height: 24,
                  ),
                  RaisedButton(
                    color: Colors.cyan,
                    child: Text('REGISTER'),
                    onPressed: ()  async {
                      try {
                        _checkData();
                        _register();
                        if (this.succRegister) {
                          await Alert(
                              context: context,
                              title: "You have been registered!",
                      buttons: [
                      DialogButton(
                      child: Text(
                      "Ok",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      width: 120,
                      )
                      ],
                      ).show();
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => MyFirst()));
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => MyLogin()));
                        }
                      } on Exception catch (e) {
                         await Alert(
                          context: context,
                          title: e.toString().substring(10),
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Ok",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _checkData() {
    _confPasswords();
    final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
    final nameregex = RegExp(r"^[a-zA-Z]+$");
    //final passwordRegex = RegExp(r'[^\s]+');
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$");
    final phonRegex = RegExp(r"^[0-9]+$");
    if (!alphanumeric.hasMatch(_username.text) ||
        !alphanumeric.hasMatch(_password.text))
      throw Exception("Nieprawidłowy znak");
    if (_password.text.length < 3 || _password.text.length > 70)
      throw Exception("Nieprawidłowa długość hasła");
    if (_username.text.length < 3 || _username.text.length > 30)
      throw Exception("Nieprawidłowa długość loginu");
    if (!emailRegex.hasMatch(_email.text)) throw Exception("Błędny email");
    if (!phonRegex.hasMatch(_phoneNumber.text) || _phoneNumber.text.length != 9)
      throw Exception("Błędny numer");
    if(!nameregex.hasMatch(_firstName.text) || _firstName.text.length < 3 ||_firstName.text.length > 30)
      throw Exception("Błędne imie");
    if(!nameregex.hasMatch(_lastName.text) || _lastName.text.length < 3 ||_lastName.text.length > 30)
      throw Exception("Błędne nazwisko");
  }

  _confPasswords() {
    if (!(_password.text == _confirmPassword.text)) {
      _password.clear();
      _confirmPassword.clear();
      throw Exception("Podane hasła nie są takie same");
    }
  }

  _registerFormField(TextEditingController controller, String text,
      {obscureText = false}) {
    return new TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
      ),
      obscureText: obscureText,
    );
  }

  _register() async {
    Map data = {
      "firstName": _firstName.text,
      "lastName": _lastName.text,
      "username": _username.text,
      "email": _email.text,
      "password": _password.text,
      "phoneNumber": _phoneNumber.text,
    };
    var jsonData;
    var response = await http.post(
      registerUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(data),
    );
    if (response.statusCode != 200)
      throw Exception(
          "Upss... wystapil problem z nawiazanie polaczenia\n Kod błędu: " +
              response.statusCode.toString());

    jsonData = json.decode(response.body);
    if (jsonData.length == 0) {
      this.succRegister = true;
    } else {
      throw Exception(response.body);
    }
  }
}
