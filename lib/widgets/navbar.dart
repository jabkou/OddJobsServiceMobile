import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.cyan,
                ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {Navigator.pushReplacementNamed(context, '/')},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Log In'),
            onTap: () => {Navigator.pushReplacementNamed(context, '/login')},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Looking for job'),
            onTap: () => {Navigator.pushReplacementNamed(context, '/catalog')},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
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