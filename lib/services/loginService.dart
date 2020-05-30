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
      throw Exception("Nieprawidłowy znak");
    if (password.length < 3 || password.length > 30)
      throw Exception("Nieprawidłowa długość hasła");
    if (login.length < 3 || login.length > 30)
      throw Exception("Nieprawidłowa długość loginu");
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
          "Upss... wystapil problem z nawiazanie polaczenia\n Kod błędu:" +
              response.statusCode.toString());
    jsonData = json.decode(response.body);
    if (jsonData["success"] == "true") {
      user.update(response: response);
      await getUserData(user, login);
    } else {
      throw DiffPasswordException("Nieprawidłowy login lub hasło");
    }
  }

  getUserData(User user, String login) async {

    var response = await http.get(
      userDataUrl + login,
      headers: user.getHeaders(),
    );
    if (response.statusCode != 200)
      throw Exception("Blad polaczenia: " + response.statusCode.toString());
    var data = json.decode(response.body);
    user.update(
        userName: login,
        firstName: data["firstName"],
        lastName: data["lastName"],
        email: data["email"],
        phoneNumber: data["phoneNumber"],
        userProfilePhotoUrl: data["userProfilePhotoUrl"],
        blocked: data["blocked"],
        login: true);
  }
}
