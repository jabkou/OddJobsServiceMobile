import 'package:flutter/material.dart';
import 'package:flutterappservice/screens/catalog.dart';
import 'package:flutterappservice/screens/first.dart';
import 'package:flutterappservice/screens/login.dart';
import 'package:flutterappservice/screens/myAccount.dart';
import 'package:flutterappservice/screens/register.dart';
import 'package:provider/provider.dart';

import 'common/theme.dart';
import 'models/user.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return ChangeNotifierProvider<User>(
      create: (BuildContext context) => User.emptyUser(),
      child: MaterialApp(
        title: 'Provider Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => MyFirst(),
          '/login': (context) => MyLogin(),
          '/catalog': (context) => MyCatalog(),
          '/register': (context) => Register(),
          '/myAccount': (context) => MyAccount(),
        },
      ),
    );
  }
}
