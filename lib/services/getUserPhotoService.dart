import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterappservice/common/constants.dart';

class GetUserPhotoService {
  Image getUserProfilePhoto(String username) {
    Image img;
    try {
      img = Image.network(
        getUserPhotoURL + username,
      );
    } on Exception catch (_) {
      img = Image.file(new File('../images/test.png'));
    }
    return img;
  }
}
