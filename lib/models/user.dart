import 'package:flutter/cupertino.dart';

class User with ChangeNotifier {
  String _userName;
  String _firstName;
  String _lastName;
  String _email;
  String _phoneNumber;
  List _userProfilePhotoUrl; //if they add
  bool _blocked;
  bool _login;
  User.emptyUser() {
    //named consturctor
    this._login = false;
  }
  String getUserName() {
    return _userName;
  }

  String getFirstName() {
    return _firstName;
  }

  String getLastName() {
    return _lastName;
  }

  String getEmail() {
    return _email;
  }

  String getPhoneNumber() {
    return _phoneNumber;
  }

  List getUserProfilePhotoUrl() {
    return _userProfilePhotoUrl;
  }

  bool isBlocked() {
    return _blocked;
  }

  bool isLogin() {
    return _login;
  }

  void update(
      {String userName,
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      List userProfilePhotoUrl,
      bool blocked,
      bool login}) {
    if (userName != null)
      _userName = userName;
    if (firstName != null)
      _firstName = firstName;
    if (lastName != null)
      _lastName = lastName;
    if (email != null)
      _email = email;
    if (phoneNumber != null)
      _phoneNumber = phoneNumber;
    if (userProfilePhotoUrl != null)
      _userProfilePhotoUrl = userProfilePhotoUrl;
    if (blocked != null)
      _blocked = blocked;
    if (login != null)
      _login = login;
    notifyListeners();
  }
}
