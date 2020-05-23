import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappservice/models/advertisementModel.dart';
import 'package:flutterappservice/services/addAdvertisementsService.dart';
import 'package:flutterappservice/widgets/alertbox.dart';
import 'package:flutterappservice/widgets/navbar.dart';


class AddAdvertisementPage extends StatefulWidget {
  @override
  _AddAdvertisementPage createState() => _AddAdvertisementPage();
}

class _AddAdvertisementPage extends State<AddAdvertisementPage> {
  AddAdvertisementsService addAdvertisementsService = new AddAdvertisementsService();
  final TextEditingController title = new TextEditingController();
  final TextEditingController description = new TextEditingController();
  final TextEditingController category = new TextEditingController();
  bool succAdd = false;

  @override
  Widget build(BuildContext context) {
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
                Color.fromRGBO(255, 255, 255, 0.5), BlendMode.modulate),
          ),
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(40.0, 80.0, 40.0, 100.0),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Add new Advertisement:',
                    style: Theme.of(context).textTheme.display4,
                  ),
                  textFormField(title, 'Title'),
                  textFormField(description, 'Description', maxLines: 10),
                  textFormField(category, 'Category'),

                  SizedBox(
                    height: 24,
                  ),
                  RaisedButton(
                    color: Colors.cyan,
                    child: Text('Add'),
                    onPressed: () {
                      try {
                        addAdvertisementsService.addAdvertisement(title.text, description.text, category.text);
                        AlertBox.showAlertDialog(context, "New Advertisement added",'', "OK");
                        //Navigator.pushReplacementNamed(context, '/catalog');

                      } on Exception catch (e) {
                        AlertBox.showAlertDialog(
                            context, "Upss... There is problem\n", e.toString(), "OK");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  textFormField(TextEditingController controller, String text, {maxLines = 1, obscureText = false}) {
    return new TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: text,
      ),
      obscureText: obscureText,
    );
  }


}






//class AddAdvertisementPage extends StatelessWidget {
//  AddAdvertisementPage();
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text("jghd"),
//        ),
//        body: Column(
//          children: <Widget>[
//            Container(
//                height: 300,
//                width: double.infinity,
//                decoration: BoxDecoration(
//                    gradient: LinearGradient(
//                        begin: Alignment.topCenter,
//                        end: Alignment.bottomCenter,
//                        colors: [Colors.cyan, Colors.white])),
//                child: Image.network(
//                    ("https://randomuser.me/api/portraits/men/75.jpg"))),
//            Container(
//              child: Text("advertisement.description"),
//            )
//          ],
//        ));
//  }
//}
