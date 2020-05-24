import 'package:flutter/material.dart';
import 'package:flutterappservice/models/user.dart';
import 'package:flutterappservice/widgets/navbar.dart';
import 'package:provider/provider.dart';

class MyAccount extends StatelessWidget {
  User user;
  @override
  Widget build(BuildContext context) {
    this.user = Provider.of<User>(context);
    String firstName, lastName, email, phoneNumber, userName;
    userName = this.user.getUserName();
    firstName = this.user.getFirstName();
    lastName = this.user.getLastName();
    email = this.user.getEmail();
    phoneNumber = this.user.getPhoneNumber();

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomPadding: false,
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
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
              Text('My account:',
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
                subtitle: Text(userName,
                    style: TextStyle(fontWeight: FontWeight.bold)
                ),
                leading: Icon(
                  Icons.account_box,
                  color: Colors.blue[500],
                ),
              ),
              Divider(),
              ListTile(
                title: Text('First name',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text(firstName,
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
                subtitle: Text(lastName,
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
                subtitle: Text(email,
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
                subtitle: Text(phoneNumber,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                leading: Icon(
                  Icons.contact_phone,
                  color: Colors.blue[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
