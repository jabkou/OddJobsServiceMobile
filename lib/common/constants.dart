import 'dart:ui';

import 'package:flutter/material.dart';

final String registerUrl = "http://149.156.146.249:60021/api/users";
final String loginUrl = "http://149.156.146.249:60021/api/login";
final String userDataUrl = "http://149.156.146.249:60021/api/users/";
final String advertisementsURL =
    "http://149.156.146.249:60021/api/advertisements";

List<String> categories = [
  "HOUSEWORK",
  "ANIMALSCARE",
  "GARDENCARE"
];

//TODO - why this don't work, repair and use them everywhere
Color primaryColor = const Color.fromARGB(255, 66, 165, 245);
//Color.fromARGB(0X00,0x50,0x85,0x93);
final Color secondaryColor = Colors.black;
//Color(0Xfff2d2ec);
final Color infoColor = Color(0X544f63);
final Color lightColor = Color(0Xeeeeee);
final Color darkColor = Color(0X121214);
