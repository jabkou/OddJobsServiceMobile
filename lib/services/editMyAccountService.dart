import 'dart:convert';
import 'package:flutterappservice/common/constants.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class EditMyAccountService {
  _checkData({String password, String email, String firstName,
      String lastName, String phoneNumber}) {
    final alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
    final nameregex = RegExp(r"^[a-zA-Z]+$");
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$");
    final phonRegex = RegExp(r"^[0-9]+$");
    if (password != null && !alphanumeric.hasMatch(password))
      throw Exception("Invalid character");
    if (password != null && (password.length < 3 || password.length > 70))
      throw Exception("Invalid length of password");
    if (email != null && !emailRegex.hasMatch(email)) throw Exception("Wrong Email");
    if (phoneNumber != null && (!phonRegex.hasMatch(phoneNumber) || phoneNumber.length != 9))
      throw Exception("Wrong phone numer");
    if (firstName != null && (!nameregex.hasMatch(firstName) ||
        firstName.length < 3 ||
        firstName.length > 30)) throw Exception("Wrong name");
    if (lastName != null && (!nameregex.hasMatch(lastName) ||
        lastName.length < 3 ||
        lastName.length > 30)) throw Exception("Wrong surname");
  }
  updateMyAccount(User user, String password, String firstName, String lastName, String email, String phoneNumber) async{
    _checkData(
      password: password != 'password' ? password : null,
      email: email != user.getEmail() ? email : null,
      firstName: firstName != user.getFirstName() ? firstName : null,
      lastName: lastName != user.getLastName() ? lastName : null,
      phoneNumber: phoneNumber != user.getPhoneNumber() ? phoneNumber : null
    );
        Map data = {
      "firstName": firstName,
      "lastName": lastName,
      "username": user.getUserName(),
      "email": email,
      "phoneNumber": phoneNumber,
    };
    if(password != 'password')
      data.addAll({"password": password});
    var jsonData;
    var response = await http.patch(
      editMyAccountURL,
      headers: user.getHeaders(),
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
    user.update(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
    );
  }
}
