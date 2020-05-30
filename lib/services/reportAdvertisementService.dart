import 'dart:convert';

import 'package:flutterappservice/common/constants.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class ReportAdvertisementsService {
  checkData(String description) {
    final alphanumeric = RegExp("^\\s*[\\da-zA-Z][\\da-zA-Z\\s]*");
    if (description == null || description.isEmpty) throw Exception("You can not leave empty fields");
    if (!alphanumeric.hasMatch(description))
      throw Exception("Invalid character in title or description");
    if (description.length > 255)
      throw Exception("Invalid length of description");
  }

  reportAdvertisement(User user,
      String advertisementID,
      String description) async {
    await checkData(description);
    Map advertisement = {
      "advertisementID": advertisementID
    };
    Map data = {
      "advertisement": advertisement,
      "description": description
    };

    var response = await http.post(reportAdvertisementsURL,
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