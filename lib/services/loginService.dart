import 'dart:convert';
import 'package:flutterappservice/common/constants.dart';
import 'package:flutterappservice/exceptions/diffPasswordException.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class LoginService {

  _checkData(String login, String password) {
    final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
    if (!alphanumeric.hasMatch(login) ||
        !alphanumeric.hasMatch(password))
      throw Exception("Invalid character");
    if (password.length < 3 || password.length > 30)
      throw Exception("Invalid length of password");
    if (login.length < 3 || login.length > 30)
      throw Exception("Invalid length of login");
  }

  signIn(User user, String login, String password) async {
    _checkData(login, password);
    Map data = {
      'username': login,
      'password': password,
    };
    var jsonData;
    var response = await http.post(
      loginUrl,
      headers: user.getHeaders(),
      body: json.encode(data),
    );
    if (response.statusCode != 200)
      throw Exception(
          "Upss... There is problem\n\tError code: " +
              response.statusCode.toString());
    jsonData = json.decode(response.body);
    if (jsonData["success"] != "true") {
      throw DiffPasswordException("Wrong login or password");
    }
    user.update(response: response);
    await getUserData(user, login);
  }

  getUserData(User user, String login) async {

    var response = await http.get(
      userDataUrl + login,
      headers: user.getHeaders(),
    );
    if (response.statusCode != 200)
      throw Exception("Upss... There is problem\n\tError code: " + response.statusCode.toString());
    var data = json.decode(response.body);

    user.update(
        userName: login,
        firstName: data["firstName"],
        lastName: data["lastName"],
        email: data["email"],
        phoneNumber: data["phoneNumber"],
        blocked: data["blocked"],
        login: true);
  }
}
