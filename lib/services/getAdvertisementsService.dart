import 'dart:convert';

import 'package:flutterappservice/common/constants.dart';
import 'package:flutterappservice/models/advertisementModel.dart';
import 'package:http/http.dart';

class GetAdvertisementsService {
  Future<List<Advertisement>> getPosts() async {
    Response res = await get(advertisementsURL);
    //+"?city=WARSZAWA"
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Advertisement> posts = body
          .map(
            (dynamic item) => Advertisement.fromJson(item),
          )
          .toList();
      return posts;
    } else {
      throw "Can't get posts.";
    }
  }
}
