import 'dart:convert';

import 'package:flutterappservice/common/constants.dart';
import 'package:http/http.dart' as http;


class AddAdvertisementsService {
  checkData(String title, String description) {
    final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');

    if (!alphanumeric.hasMatch(title) ||
        !alphanumeric.hasMatch(description))
      throw Exception("Invalid sigh");
    if (title.length < 13 || title.length > 70)
      throw Exception("Invalid length of title");
    if (description.length > 255)
      throw Exception("Invalid length of title");
  }

  addAdvertisement(String title, String description, String category) async {
    checkData(title, description)=>throw Exception();
    Map data = {
      "title": title,
      "description": description,
      "category": category
    };
    print(data.toString());
    var response = await http.post(
      advertisementsURL,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(data)
    );
    if (response.statusCode != 200)
      throw Exception(
          "Upss... There is problem\n\tError code: " +
              response.statusCode.toString());

    var jsonData = json.decode(response.body);
    if (jsonData.length != 0) {
      throw Exception(response.body);
    }
  }
}
