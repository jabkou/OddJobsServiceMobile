import 'dart:convert';
import 'package:flutterappservice/common/constants.dart';
import 'package:flutterappservice/exceptions/diffPasswordException.dart';
import 'package:http/http.dart' as http;

class RegisterService {
  _checkData(String username, String password, String email, String firstName,
      String lastName, String phoneNumber, String confirmPassword) {
    _confPasswords(password, confirmPassword);
    final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
    final nameregex = RegExp(r"^[a-zA-Z]+$");
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$");
    final phonRegex = RegExp(r"^[0-9]+$");
    if (!alphanumeric.hasMatch(username) || !alphanumeric.hasMatch(password))
      throw Exception("Invalid character");
    if (password.length < 3 || password.length > 70)
      throw Exception("Invalid length of password");
    if (username.length < 3 || username.length > 30)
      throw Exception("Invalid length of login");
    if (!emailRegex.hasMatch(email)) throw Exception("Wrong Email");
    if (!phonRegex.hasMatch(phoneNumber) || phoneNumber.length != 9)
      throw Exception("Wrong phonenumer");
    if (!nameregex.hasMatch(firstName) ||
        firstName.length < 3 ||
        firstName.length > 30) throw Exception("Wrong name");
    if (!nameregex.hasMatch(lastName) ||
        lastName.length < 3 ||
        lastName.length > 30) throw Exception("Wrong surname");
  }

  _confPasswords(String password, String confirmPassword) {
    if (!(password == confirmPassword)) {
      throw DiffPasswordException("Upss... There is problem\n\tError code: ");
    }
  }

  register(String username, String password, String email, String firstName,
      String lastName, String phoneNumber, String confirmPassword) async {
    _checkData(username, password, email, firstName, lastName, phoneNumber,
        confirmPassword);
    Map data = {
      "firstName": firstName,
      "lastName": lastName,
      "username": username,
      "email": email,
      "password": password,
      "phoneNumber": phoneNumber,
    };
    var jsonData;
    var response = await http.post(
      registerUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(data),
    );
    if (response.statusCode != 200)
      throw Exception(
          "Upss... There is problem\n\tError code: " +
              response.statusCode.toString());

    jsonData = json.decode(response.body);
    if (jsonData.length != 0) {
      throw Exception(response.body);
    } 
  }
}
