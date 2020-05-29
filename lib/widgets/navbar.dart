import 'package:flutter/material.dart';
import 'package:flutterappservice/models/user.dart';

import 'package:flutterappservice/screens/addAdvertisement.dart';
import 'package:flutterappservice/screens/catalog.dart';
import 'package:flutterappservice/screens/first.dart';
import 'package:flutterappservice/screens/login.dart';
import 'package:flutterappservice/screens/myAccount.dart';
import 'package:flutterappservice/screens/register.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:provider/provider.dart';


class NavDrawer extends StatelessWidget {
  User user;
  @override
  Widget build(BuildContext context) {
    this.user = Provider.of<User>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Image(image: AssetImage("images/logo.png")),
            decoration: BoxDecoration(
              color: Colors.cyan,
            ),
          ),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text('Welcome'),
            onTap: () => {Navigator.push(
            context,
            new MaterialPageRoute(
            builder: (context) => MyFirst()))},
          ),
          if(!user.isLogin())
            ListTile(
              leading: Icon(Icons.input),
              title: Text('Log In'),
              onTap: () => {Navigator.push(
              context,
              new MaterialPageRoute(
              builder: (context) => MyLogin()))},
            ),
          if(user.isLogin())
            ListTile(
              leading: Icon(Icons.input),
              title: Text('My account'),
              onTap: () => {Navigator.push(
              context,
              new MaterialPageRoute(
              builder: (context) => MyAccount()))},
            ),
          if(!user.isLogin())
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Register'),
              onTap: () => {Navigator.push(
              context,
              new MaterialPageRoute(
              builder: (context) => Register()))},
            ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Looking for job'),
            onTap: () => {Navigator.push(
            context,
            new MaterialPageRoute(
            builder: (context) => Catalog()))},
          ),
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: Text('Add job'),
            onTap: () async {
              if (user.isLogin()) {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => AddAdvertisementPage()));
              } else {
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
              },
          ),
          if(user.isLogin())
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () => {Navigator.of(context).pop()},
            ),
        ],
      ),
    );
  }
}