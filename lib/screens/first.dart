import 'package:flutter/material.dart';
import 'package:flutterappservice/models/user.dart';
import 'package:flutterappservice/screens/catalog.dart';
import 'package:flutterappservice/screens/login.dart';
import 'package:flutterappservice/widgets/navbar.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'addAdvertisement.dart';

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
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => Catalog()));
                },
              ),
              RaisedButton(
                color: Colors.cyan,
                child: Text('ADD JOB'),
                onPressed: () async {
                  if(!user.isLogin()) {
                    await Alert(
                        context: context,
                        title: "You need to log in first",
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
                            builder: (context) => AddAdvertisementPage()));
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => MyLogin()));
                  }
                  if(user.isLogin())
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => AddAdvertisementPage()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
