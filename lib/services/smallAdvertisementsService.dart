import 'dart:convert';

import 'package:flutterappservice/common/constants.dart';
import 'package:flutterappservice/models/shortAdvertisementModel.dart';
import 'package:http/http.dart';

class SmallAdvertisementsService {
  Future<List<ShortAdvertisements>> getPosts() async {
    Response res = await get(advertisementsURL);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<ShortAdvertisements> posts = body
          .map(
            (dynamic item) => ShortAdvertisements.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      throw "Can't get posts.";
    }
  }
}
