import 'dart:convert';

import 'package:flutterappservice/common/constants.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/user.dart';

class AddAdvertisementsService {
  checkData(String title, String description, String reward) {
    final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
    final numeric = RegExp(r'^[0-9]+$');
    if (!alphanumeric.hasMatch(title) || !alphanumeric.hasMatch(description))
      throw Exception("Invalid sigh");
    if (title.length < 13 || title.length > 70)
      throw Exception("Invalid length of title");
    if (description.length > 255) throw Exception("Invalid length of title");
    if (!numeric.hasMatch(reward)) throw Exception("Reward must be full number");
  }

  addAdvertisement(User user, String title, String description, String category,
      String city, String workingHours, String contractType, String reward) async {
    checkData(title, description, reward) => throw Exception();
    Map data = {
      "title": title,
      "description": description,
      "advertisementCategory": category,
      "city": city,
      "workingHours": workingHours,
      "contractType": contractType,
      "reward": reward,
    };

    var response = await http.post(advertisementsURL,
        headers: user.getHeaders(), body: json.encode(data));
    user.update(response: response);

    if (response.statusCode != 200)
      throw Exception("Upss... There is problem\n\tError code: " +
          response.statusCode.toString());

    var jsonData = json.decode(response.body);
    if (jsonData.length != 0) {
      print(response.body);
    }
  }
}
