import 'package:flutter/material.dart';
import 'package:flutterappservice/models/user.dart';
import 'package:flutterappservice/widgets/navbar.dart';
import 'package:provider/provider.dart';

class MyFirst extends StatelessWidget {
  User user;
  @override
  Widget build(BuildContext context) {
    this.user = Provider.of<User>(context);
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
          ),
        ),

        child: Container(
          padding: EdgeInsets.fromLTRB(100.0, 0.0, 100.0, 150.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage("images/logo.png")),
              SizedBox(height: 80),
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              if(user.isLogin())
                Text(
                  user.getFirstName(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              Text(
                'What you want to do?\n',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              RaisedButton(
                color: Colors.cyan,
                child: Text('SEARCH FOR JOBS'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/catalog');
                },
              ),
              RaisedButton(
                color: Colors.cyan,
                child: Text('ADD JOB'),
                onPressed: () {
                  if(!user.isLogin())
                    Navigator.pushReplacementNamed(context, '/login');
                  if(user.isLogin())
                    Navigator.pushReplacementNamed(context, '/myAccount');  //TODO
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
