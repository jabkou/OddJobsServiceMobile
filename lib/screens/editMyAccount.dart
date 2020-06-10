import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterappservice/models/user.dart';
import 'package:flutterappservice/services/editMyAccountService.dart';
import 'package:flutterappservice/services/getUserPhotoService.dart';
import 'package:flutterappservice/services/updateUserProfilPhoto.dart';
import 'package:flutterappservice/widgets/alertbox.dart';
import 'package:flutterappservice/widgets/navbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'myAccount.dart';

class EditMyAccount extends StatefulWidget {
  @override
  _EditMyAccountState createState() => _EditMyAccountState();
}

class _EditMyAccountState extends State<EditMyAccount> {
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _firstName = new TextEditingController();
  final TextEditingController _lastName = new TextEditingController();
  final TextEditingController _phoneNumber = new TextEditingController();
  final EditMyAccountService _editMyAccountService = new EditMyAccountService();
  final GetUserPhotoService _getUserPhotoService = new GetUserPhotoService();
  final UpdateUserProfilPhoto _updateUserProfilPhoto =
      new UpdateUserProfilPhoto();
  Image _userImage;
  File _userNewPhoto;

  @override
  Widget build(BuildContext context) {
    User user;
    user = Provider.of<User>(context, listen: false);
    if (_userNewPhoto == null)
    _userImage = _getUserPhotoService.getUserProfilePhoto(user.getUserName());
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bck.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Color.fromRGBO(255, 255, 255, 0.3), BlendMode.modulate),
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
            child: Column(
              children: [
                Text(
                  'Edit my account:',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 24,
                ),
                _newElement('Password', 'password', Icons.lock, _password),
                _newElement(
                    'First name', user.getFirstName(), Icons.face, _firstName),
                _newElement(
                    'Last name', user.getLastName(), Icons.people, _lastName),
                _newElement(
                    'Email', user.getEmail(), Icons.contact_mail, _email),
                _newElement('Phone number', user.getPhoneNumber(),
                    Icons.contact_phone, _phoneNumber),
                Container(
                  child: _userImage,//_userNewPhoto != null ? Image.file(_userNewPhoto) : _getUserPhotoService.getUserProfilePhoto(user),
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.cyan,
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.blue[500],
                      ),
                      onPressed: () => _imagePicker(ImageSource.camera),
                    ),
                    RaisedButton(
                      color: Colors.cyan,
                      child: Icon(
                        Icons.photo_album,
                        color: Colors.blue[500],
                      ),
                      onPressed: () => _imagePicker(ImageSource.gallery),
                    ),
                  ],
                ),
                RaisedButton(
                  color: Colors.cyan,
                  child: Text('UPDATE'),
                  onPressed: () async {
                    try {
                      await _editMyAccountService.updateMyAccount(
                          user,
                          _password.text,
                          _firstName.text,
                          _lastName.text,
                          _email.text,
                          _phoneNumber.text);
                      if (_userNewPhoto != null)
                        await _updateUserProfilPhoto.updateProfilPhoto(
                            user, _userNewPhoto);
                      Navigator.pushReplacementNamed(context, '/myAccount');
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (BuildContext context) => MyAccount(),
                          ),
                          (Route<dynamic> route) => false);
                    } catch (e) {
                      AlertBox.showAlertDialog(context, "Problem...",
                          e.toString().substring(11), "OK");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _newElement(String name, String value, IconData icon,
      TextEditingController controller) {
    return new Column(
      children: [
        ListTile(
          title: Text(name, style: TextStyle(fontWeight: FontWeight.w500)),
          leading: Icon(
            icon,
            color: Colors.blue[500],
          ),
        ),
        TextFormField(
          controller: controller..text = value,
        ),
      ],
    );
  }

  _imagePicker(ImageSource source) async {
    _userNewPhoto = await ImagePicker.pickImage(source: source);
    setState(() {
      imageCache.clear();
      _userImage = Image.file(_userNewPhoto);
    });
  }
}
