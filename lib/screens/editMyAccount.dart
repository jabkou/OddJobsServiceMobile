import 'package:flutter/material.dart';
import 'package:flutterappservice/models/user.dart';
import 'package:flutterappservice/services/editMyAccountService.dart';
import 'package:flutterappservice/widgets/alertbox.dart';
import 'package:flutterappservice/widgets/navbar.dart';
import 'package:provider/provider.dart';
import 'myAccount.dart';

class EditMyAccount extends StatelessWidget {
  final TextEditingController _password = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _firstName = new TextEditingController();
  final TextEditingController _lastName = new TextEditingController();
  final TextEditingController _phoneNumber = new TextEditingController();
  final EditMyAccountService editMyAccountService = new EditMyAccountService();

  @override
  Widget build(BuildContext context) {
    User user;
    user = Provider.of<User>(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
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
        child: SingleChildScrollView(
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
                _newElement('First name', user.getFirstName(), Icons.face, _firstName),
                _newElement('Last name', user.getLastName(), Icons.people, _lastName),
                _newElement('Email', user.getEmail(), Icons.contact_mail, _email),
                _newElement(
                    'Phone number', user.getPhoneNumber(), Icons.contact_phone, _phoneNumber),
                RaisedButton(
                  color: Colors.cyan,
                  child: Text('UPDATE'),
                  onPressed: () async {
                    try{
                    await editMyAccountService.updateMyAccount(
                      user,
                      _password.text,
                      _firstName.text,
                      _lastName.text,
                      _email.text,
                      _phoneNumber.text
                    );
                    Navigator.pushReplacementNamed(context, '/myAccount');
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) => MyAccount(),
                        ),
                        (Route<dynamic> route) => false);
                    } catch (e){
                      AlertBox.showAlertDialog(
                        context, "Problem...", e.toString().substring(11), "OK");
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

  _newElement(String name, String value, IconData icon, TextEditingController controller) {
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
}
