import 'package:flutter/material.dart';
import 'package:flutterappservice/common/constants.dart';
import 'package:flutterappservice/exceptions/diffPasswordException.dart';
import 'package:flutterappservice/models/user.dart';
import 'package:flutterappservice/screens/myAccount.dart';
import 'package:flutterappservice/services/loginService.dart';
import 'package:flutterappservice/widgets/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';
import '../widgets/alertbox.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final TextEditingController _login = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  LoginService loginService = new LoginService();
  User user;

  @override
  Widget build(BuildContext context) {
    this.user = Provider.of<User>(context);
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
                onPressed: () async {
                  try {
                    await loginService.signIn(user, _login.text, _password.text);
                    Navigator.pushReplacementNamed(context, '/myAccount');
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) => MyAccount(),
                        ), //zmiana na zalogowany screen
                        (Route<dynamic> route) => false);
                  } on DiffPasswordException catch (e) {
                    _password.clear();
                    AlertBox.showAlertDialog(
                        context, "Problem...", e.toString(), "OK");
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
}
