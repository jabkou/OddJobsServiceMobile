class User{
  String _userName;
  String _firstName;
  String _lastName;
  String _email;
  String _phoneNumber;
  List _userProfilePhotoUrl;
  bool _blocked;
  User(this._userName, this._firstName, this._lastName, this._email, this._phoneNumber, this._userProfilePhotoUrl, this._blocked);
  String getUserName(){
    return _userName;
  }
  String getFirstName(){
    return _firstName;
  }
  String getLastName(){
    return _lastName;
  }
  String getEmail(){
    return _email;
  }
  String getPhoneNumber(){
    return _phoneNumber;
  }
  List getUserProfilePhotoUrl(){
    return _userProfilePhotoUrl;
  }
  bool ifBlocked(){
    return _blocked;
  }
}