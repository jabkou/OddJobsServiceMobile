import 'dart:convert';

import 'package:flutterappservice/common/constants.dart';
import 'package:http/http.dart';

class DeleteAdvertisementsService {
  void deleteAdvertisement(id) async {
    Response response = await delete(advertisementsURL+"?id="+id);
    if (response.statusCode != 200)
      throw Exception("Upss... There is problem\n\tError code: " +
          response.statusCode.toString());

    var jsonData = json.decode(response.body);
    if (jsonData != true) {
      throw "Could not delete this advertisement";
    }
  }
}
