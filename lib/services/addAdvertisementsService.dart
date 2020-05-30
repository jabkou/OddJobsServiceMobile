import 'dart:convert';

import 'package:flutterappservice/common/constants.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class AddAdvertisementsService {
  checkData(String title, String description, String category, String city,
      String workingHours, String contractType, String reward) {
    final alphanumeric = RegExp("^\\s*[\\da-zA-Z][\\da-zA-Z\\s]*");
    final numeric = RegExp(r'^[0-9]+$');
    if (title == null ||
        description == null ||
        category == null ||
        city == null ||
        workingHours == null ||
        contractType == null ||
        reward == null) throw Exception("You can not leave empty fields");
    if (title.isEmpty ||
    description.isEmpty ||
    category.isEmpty ||
    city.isEmpty ||
    workingHours.isEmpty ||
    contractType.isEmpty ||
    reward.isEmpty) throw Exception("You can not leave empty fields");
    if (title.length < 13 || title.length > 70)
    throw Exception("Invalid length of title");
    if (!alphanumeric.hasMatch(title) || !alphanumeric.hasMatch(description))
    throw Exception("Invalid character in title or description");
    if (description.length > 255)
    throw Exception("Invalid length of description");
    if (!numeric.hasMatch(reward))
    throw Exception("Reward must be full number");
  }

  addAdvertisement(User user,
      String title,
      String description,
      String category,
      String city,
      String workingHours,
      String contractType,
      String reward) async {
    await checkData(
        title,
        description,
        category,
        city,
        workingHours,
        contractType,
        reward);
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
      throw (response.body.toString());
    }
  }
}
