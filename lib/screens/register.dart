import 'package:flutter/material.dart';
import 'package:flutterappservice/common/constants.dart';
import 'package:flutterappservice/screens/login.dart';
import 'package:flutterappservice/widgets/navbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _username = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _firstName = new TextEditingController();
  final TextEditingController _lastName = new TextEditingController();
  final TextEditingController _phoneNumber = new TextEditingController();

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
                  TextFormField(
                    controller: _username,
                    decoration: InputDecoration(
                      hintText: 'Login',
                    ),
                  ),
                  TextFormField(
                    controller: _password,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  TextFormField(
                    controller: _password,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                    obscureText: true,
                  ),
                  TextFormField(
                    controller: _firstName,
                    decoration: InputDecoration(
                      hintText: 'Name',
                    ),
                  ),
                  TextFormField(
                    controller: _lastName,
                    decoration: InputDecoration(
                      hintText: 'Surname',
                    ),
                  ),
                  TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                      hintText: 'e-mail',
                    ),
                  ),
                  TextFormField(
                    controller: _phoneNumber,
                    decoration: InputDecoration(
                      hintText: 'phone number',
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  RaisedButton(
                    color: Colors.cyan,
                    child: Text('REGISTER'),
                    onPressed: () {
                      _register();
                      Navigator.pushReplacementNamed(context, '/login');
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
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      if (jsonData != null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MyLogin()),
            (Route<dynamic> route) => false);
      } else {
        print(response.body);
      }
    }
  }
}
