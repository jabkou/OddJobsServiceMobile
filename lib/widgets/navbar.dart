import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Log In'),
            onTap: () => {Navigator.pushReplacementNamed(context, '/login')},
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Register'),
            onTap: () => {Navigator.pushReplacementNamed(context, '/register')},
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Looking for job'),
            onTap: () => {Navigator.pushReplacementNamed(context, '/catalog')},
          ),
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: Text('Add job'),
            onTap: () => {Navigator.pushReplacementNamed(context, '/login')},
          ),
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