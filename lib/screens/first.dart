import 'package:flutter/material.dart';
import 'package:flutterappservice/widgets/navbar.dart';

class MyFirst extends StatelessWidget {
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
          ),
        ),

        child: Container(
          padding: EdgeInsets.fromLTRB(100.0, 0.0, 100.0, 150.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome! \n What you want to do?\n',
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
                  Navigator.pushReplacementNamed(context, '/login');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
