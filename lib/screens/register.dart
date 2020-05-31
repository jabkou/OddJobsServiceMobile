import 'package:flutter/material.dart';
import 'package:flutterappservice/exceptions/diffPasswordException.dart';
import 'package:flutterappservice/screens/login.dart';
import 'package:flutterappservice/services/registerService.dart';
import 'package:flutterappservice/widgets/navbar.dart';
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
  RegisterService registerService = new RegisterService();

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
          padding: EdgeInsets.fromLTRB(80.0, 80.0, 80.0, 100.0),
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
                    onPressed: () async {
                      try {
                        await registerService.register(
                            _username.text,
                            _password.text,
                            _email.text,
                            _firstName.text,
                            _lastName.text,
                            _phoneNumber.text,
                            _confirmPassword.text);
                        Navigator.pushReplacementNamed(context, '/login');
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) => MyLogin()),
                            (Route<dynamic> route) => false);
                      } on DiffPasswordException catch(e){
                        _password.clear();
                        _confirmPassword.clear();
                        AlertBox.showAlertDialog(
                            context, "Problem...", e.toString(), "OK");
                      }on Exception catch (e) {
                        AlertBox.showAlertDialog(
                            context, "Problem...", e.toString().substring(11), "OK");
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
}
