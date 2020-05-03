import 'package:flutter/material.dart';
import 'package:flutterappservice/screens/catalog.dart';
import 'package:flutterappservice/screens/first.dart';
import 'package:flutterappservice/screens/login.dart';
import 'package:provider/provider.dart';

import 'common/theme.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Provider Demo',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => MyFirst(),
          '/login': (context) => MyLogin(),
          '/catalog': (context) => Catalog(),
        },
      );
  }
}
