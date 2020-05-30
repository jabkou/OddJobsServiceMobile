import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappservice/services/reportAdvertisementService.dart';
import 'package:flutterappservice/widgets/navbar.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../models/user.dart';

// ignore: must_be_immutable
class ReportAdvertisementPage extends StatelessWidget {
  String advertisementID;
  ReportAdvertisementPage(this.advertisementID);

  ReportAdvertisementsService addAdvertisementsService =
  new ReportAdvertisementsService();
  final TextEditingController description = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    User user;
    user = Provider.of<User>(context);

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
                    'Report Advertisement:',
                    style: Theme.of(context).textTheme.display4,
                  ),
                  textFormField(description, 'Description', maxLines: 10),
                  SizedBox(
                    height: 24,
                  ),
                  RaisedButton(
                    color: Colors.cyan,
                    child: Text('Report'),
                    onPressed: () async {
                      try {
                        await addAdvertisementsService.reportAdvertisement(
                            user,
                            advertisementID,
                            description.text
                        );
                        await Alert(
                          context: context,
                          title: "Advertisement Reported",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Ok",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                        Navigator.pushReplacementNamed(context, '/catalog');
                      } catch (e) {
                        await Alert(
                          context: context,
                          title: "Upss... There is problem",
                          desc: e.toString().substring(11),
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Ok",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
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

  textFormField(TextEditingController controller, String text,
      {maxLines = 1, obscureText = false}) {
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
