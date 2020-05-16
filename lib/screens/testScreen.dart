import 'package:flutter/material.dart';
import 'package:flutterappservice/models/user.dart';
import 'package:flutterappservice/widgets/navbar.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatelessWidget {
  User user;
  @override
  Widget build(BuildContext context) {
    this.user = Provider.of<User>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomPadding: false,
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(100.0, 0.0, 100.0, 150.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            this.user.getUserName(),
            style: Theme.of(context).textTheme.display4,
          ),
          Text(
            this.user.getFirstName(),
            style: Theme.of(context).textTheme.display4,
          ),
          Text(
            this.user.getLastName(),
            style: Theme.of(context).textTheme.display4,
          ),
          Text(
            this.user.getEmail(),
            style: Theme.of(context).textTheme.display4,
          ),
          Text(
            this.user.getPhoneNumber(),
            style: Theme.of(context).textTheme.display4,
          ),
        ]),
      ),
    );
  }
}
