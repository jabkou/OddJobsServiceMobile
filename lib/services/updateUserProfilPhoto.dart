import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutterappservice/common/constants.dart';
import 'package:http_parser/http_parser.dart';
import '../models/user.dart';
class UpdateUserProfilPhoto {
  updateProfilPhoto(User user, File photo) async {
    var dio = Dio();
    FormData formData = new FormData.fromMap({
    'image':await MultipartFile.fromFile(photo.path,
      filename: photo.path.split('/').last)
    });
    dio.options.headers['cookie'] = user.getHeaders()['cookie'];
    dio.options.headers["Content-Type"] = "multipart/form-data";
    Response response = await dio
        .patch(updateUserPhotoURL, data: formData);
    if(response.statusCode == 413)
      throw Exception("Ouh... photo is too large");
    if(response.statusCode != 200)
      throw Exception("Problem with photo load");
  }
}

