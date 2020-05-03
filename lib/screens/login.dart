import 'package:flutter/material.dart';
import 'package:flutterappservice/screens/cart.dart';
import 'package:flutterappservice/widgets/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final TextEditingController _login = new TextEditingController();

  final TextEditingController _password = new TextEditingController();

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
              TextFormField(
                controller: _login,
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
              ),
              TextFormField(
                controller: _password,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 24,
              ),
              RaisedButton(
                color: Colors.cyan,
                child: Text('NEXT'),
                onPressed: () {
                  // setState(() {
                  //   _isLoading = true;
                  // });
                  this.signIn(_login, _password);
                  Navigator.pushReplacementNamed(context, '/catalog');
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  signIn(login, password) async {
    Map data = {
      'login': login,
      'password': password,
    };
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // print("hello0"); nie ma innej mozliwosci sprawdzenie bo api nie dziala ;/
    // kom sa do czekania na odp bedzie kolo ktore czeka na autoryzacje
    var jsonData;
    var response =
        await http.post("http://149.156.146.249:60021/api/login", body: data);
    // print('hello');
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      if (jsonData != null) {
        // setState(() {
        //   _isLoading = false;
        // });
        sharedPreferences.setString("token", jsonData['token']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MyCart()), (Route<dynamic> route) => false);
      } else {
        // setState(() {
        //   _isLoading = false;
        // });
        print(response.body);
      }
    }
  }
}
