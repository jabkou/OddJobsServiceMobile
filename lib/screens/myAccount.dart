import 'package:flutter/material.dart';
import 'package:flutterappservice/models/user.dart';
import 'package:flutterappservice/services/getUserPhotoService.dart';
import 'package:flutterappservice/widgets/navbar.dart';
import 'package:provider/provider.dart';
import 'editMyAccount.dart';

class MyAccount extends StatelessWidget {
  final GetUserPhotoService _getUserPhotoService = new GetUserPhotoService();
  @override
  Widget build(BuildContext context) {
    User user;
    user = Provider.of<User>(context,
        listen:
            false);
    Image userImage = _getUserPhotoService.getUserProfilePhoto(user.getUserName());
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => EditMyAccount()));
              },
            ),
          ),
        ],
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
                  'My account:',
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
                ListTile(
                  title: Text('User name',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text(user.getUserName(),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  leading: Icon(
                    Icons.account_box,
                    color: Colors.blue[500],
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('First name',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text(user.getFirstName(),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  leading: Icon(
                    Icons.face,
                    color: Colors.blue[500],
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Last name',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text(user.getLastName(),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  leading: Icon(
                    Icons.people,
                    color: Colors.blue[500],
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Email',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text(user.getEmail(),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  leading: Icon(
                    Icons.contact_mail,
                    color: Colors.blue[500],
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('Phone number',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: Text(user.getPhoneNumber(),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  leading: Icon(
                    Icons.contact_phone,
                    color: Colors.blue[500],
                  ),
                ),
                Container(
                    child: userImage,//_userNewPhoto != null ? Image.file(_userNewPhoto) : _getUserPhotoService.getUserProfilePhoto(user),
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
