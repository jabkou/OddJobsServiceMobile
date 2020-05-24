import 'package:flutter/material.dart';
import 'package:flutterappservice/models/user.dart';

import 'package:flutterappservice/screens/addAdvertisement.dart';
import 'package:flutterappservice/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:provider/provider.dart';
import 'package:flutterappservice/services/logoutService.dart';

class NavDrawer extends StatelessWidget {
  User user;
  Logout logoutService = new Logout();
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
            onTap: () => {Navigator.pushReplacementNamed(context, '/')},
          ),
          if (!user.isLogin())
            ListTile(
              leading: Icon(Icons.input),
              title: Text('Log In'),
              onTap: () => {Navigator.pushReplacementNamed(context, '/login')},
            ),
          if (user.isLogin())
            ListTile(
              leading: Icon(Icons.input),
              title: Text('My account'),
              onTap: () =>
                  {Navigator.pushReplacementNamed(context, '/myAccount')},
            ),
          if (!user.isLogin())
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Register'),
              onTap: () =>
                  {Navigator.pushReplacementNamed(context, '/register')},
            ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Looking for job'),
            onTap: () => {Navigator.pushReplacementNamed(context, '/catalog')},
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
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => MyLogin()));
              }
            },
          ),
          if (user.isLogin())
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () async {
                try {
                  await logoutService.logoutUser(user);
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/login');
                } on Exception catch (e) {
                  await Alert(
                  context: context,
                  title: "Problem",
                  buttons: [
                    DialogButton(
                      child: Text(
                        e.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                      width: 120,
                    )
                  ],
                ).show();
                }
              },
            ),
        ],
      ),
    );
  }
}
