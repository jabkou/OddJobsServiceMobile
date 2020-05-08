import 'package:flutter/material.dart';
import 'package:flutterappservice/common/constants.dart';
import 'package:flutterappservice/models/user.dart';
import 'package:flutterappservice/screens/first.dart';
import 'package:flutterappservice/widgets/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/alertbox.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final TextEditingController _login = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  User user;
  bool loginSucces = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomPadding: false,
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
          padding: EdgeInsets.fromLTRB(80.0, 0.0, 80.0, 200.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login:',
                style: Theme.of(context).textTheme.display4,
              ),
              _loginFormField(_login, 'Username'),
              _loginFormField(_password, 'Password', obscureText: true),
              SizedBox(
                height: 24,
              ),
              RaisedButton(
                color: Colors.cyan,
                child: Text('NEXT'),
                onPressed: () {
                  try {
                    this._checkData();
                    this._signIn().catchError((e) => AlertBox.showAlertDialog(
                        context, "Problem...", e.toString(), "OK"));
                    if (this.loginSucces) {
                      Navigator.pushReplacementNamed(context, '/catalog');
                    }
                  } on Exception catch (e) {
                    AlertBox.showAlertDialog(
                        context, "Problem...", e.toString(), "OK");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  _checkData() {
    final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
    if (!alphanumeric.hasMatch(_login.text) ||
        !alphanumeric.hasMatch(_password.text))
      throw Exception("Nieprawidłowy znak");
    if (_password.text.length < 3 || _password.text.length > 30)
      throw Exception("Nieprawidłowa długość hasła");
    if (_login.text.length < 3 || _login.text.length > 30)
      throw Exception("Nieprawidłowa długość loginu");
  }

  _loginFormField(TextEditingController controller, String text,
      {obscureText = false}) {
    return new TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
      ),
      obscureText: obscureText,
    );
  }

  _signIn() async {
    Map data = {
      'username': _login.text,
      'password': _password.text,
    };
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonData;
    var response = await http.post(
      loginUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(data),
    );
    if (response.statusCode != 200)
      throw Exception(
          "Upss... wystapil problem z nawiazanie polaczenia\n Kod błędu:" +
              response.statusCode.toString());
    jsonData = json.decode(response.body);
    if (jsonData["success"] == "true") {
      //sharedPreferences.setString("token", jsonData['token']);
        await _getUserData(_login.text);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MyFirst()),
            (Route<dynamic> route) => false);
        this.loginSucces = true;
      }
     else {
      _password.clear();
      throw Exception("Nieprawidłowy login lub hasło");
    }
  }

  _getUserData(String login) async {
    var response = await http.get(
      userDataUrl + login,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode != 200)
      throw Exception("Blad polaczenia: " + response.statusCode.toString());
    var data = json.decode(response.body);
    this.user = new User(
        login,
        data["firstName"],
        data["lastName"],
        data["email"],
        data["phoneNumber"],
        data["userProfilePhotoUrl"],
        data["blocked"]);
  }
}
