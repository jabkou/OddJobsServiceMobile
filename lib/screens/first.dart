import 'package:flutter/material.dart';

class MyFirst extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome! \n What you want to do?\n',
                style: Theme.of(context).textTheme.display4,
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
