import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterappservice/common/constants.dart';
import 'package:flutterappservice/models/user.dart';

class GetUserPhotoService {
  Image getUserProfilePhoto(User user) {
    Image img;
    try {
      img = Image.network(
        getUserPhotoURL + user.getUserName(),
      );
    } on Exception catch (_) {
      img = Image.file(new File('../images/test.png'));
    }
    return img;
  }
}
