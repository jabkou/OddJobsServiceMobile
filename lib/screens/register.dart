import 'package:flutter/material.dart';
import 'package:flutterappservice/screens/cart.dart';
import 'package:flutterappservice/widgets/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      // resizeToAvoidBottomPadding: false,
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
                    obscureText: true,
                  ),
                  TextFormField(
                    controller: _lastName,
                    decoration: InputDecoration(
                      hintText: 'Surname',
                    ),
                    obscureText: true,
                  ),
                  TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                      hintText: 'e-mail',
                    ),
                    obscureText: true,
                  ),
                  TextFormField(
                    controller: _phoneNumber,
                    decoration: InputDecoration(
                      hintText: 'phone number',
                    ),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  RaisedButton(
                    color: Colors.cyan,
                    child: Text('REGISTER'),
                    onPressed: () {
                      // setState(() {
                      //   _isLoading = true;
                      // });
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
  _register(){
    
  }
  // signIn(login, password) async {
  //   Map data = {
  //     'login': login,
  //     'password': password,
  //   };
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   // print("hello0"); nie ma innej mozliwosci sprawdzenie bo api nie dziala ;/
  //   // kom sa do czekania na odp bedzie kolo ktore czeka na autoryzacje
  //   var jsonData;
  //   var response =
  //       await http.post("http://149.156.146.249:60021/api/login", body: data);
  //   if (response.statusCode == 200) {
  //     jsonData = json.decode(response.body);
  //     if (jsonData != null) {
  //       // setState(() {
  //       //   _isLoading = false;
  //       // });
  //       sharedPreferences.setString("token", jsonData['token']);
  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(builder: (BuildContext context) => MyCart()),
  //           (Route<dynamic> route) => false);
  //     } else {
  //       // setState(() {
  //       //   _isLoading = false;
  //       // });
  //       print(response.body);
  //     }
  //   }
  // }
}
