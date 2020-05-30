import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappservice/models/advertisementModel.dart';
import 'package:flutterappservice/models/user.dart';
import 'package:flutterappservice/screens/reportAdvertisement.dart';
import 'package:flutterappservice/services/deleteAdvertisementService.dart';
import 'package:flutterappservice/services/loginService.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

import 'login.dart';

//TODO The specific RenderFlex in question is: RenderFlex#0596a relayoutBoundary=up1 OVERFLOWING
// ignore: must_be_immutable
class DetailPage extends StatelessWidget {
  final Advertisement advertisement;
  DetailPage(this.advertisement);
  LoginService loginService = new LoginService();
  @override
  Widget build(BuildContext context) {
    User user, author = User.emptyUser();
    user = Provider.of<User>(context);
    loginService.getUserData(author, advertisement.createdBy);
    final coursePrice = Container(
      padding: const EdgeInsets.all(2.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        advertisement.reward.toString()+" zł",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 50.0),
        Text(
          advertisement.title,
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        SizedBox(height: 220.0),

        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      advertisement.city,
                      style: TextStyle(color: Colors.white),
                    ))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      advertisement.contractType,
                      style: TextStyle(color: Colors.white),
                    ))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      advertisement.workingHours,
                      style: TextStyle(color: Colors.white),
                    ))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      advertisement.category,
                      style: TextStyle(color: Colors.white),
                    ))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "",
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(flex: 1, child: coursePrice)
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 5.0),
          height: MediaQuery.of(context).size.height * 0.5,
          child:
              Image.network("https://randomuser.me/api/portraits/men/75.jpg"),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(0,255,255, .4)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );



    final bottomContentText = Text(
      advertisement.description,
      style: TextStyle(fontSize: 18.0),
    );
    final callButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () async => await launch("tel:"+author.getPhoneNumber()),
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Text("Call me!", style: TextStyle(color: Colors.white)),
        ));
    final mailButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () async => await launch("mailto:"+author.getEmail()),
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Text("Mail me!", style: TextStyle(color: Colors.white)),
        ));
    final reportButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () async {
            if(user.isLogin()){
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ReportAdvertisementPage(advertisement.advertisementID.toString())));
            } else{
              await Alert(
                context: context,
                title: "You need to log in first",
                buttons: [
                  DialogButton(
                    child: Text(
                      "Ok",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    width: 120,
                  ),
                ],
              ).show();
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => MyLogin()));
            }
          },
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Text("Report advertisement", style: TextStyle(color: Colors.white)),
        ));
    final deleteButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () async {
            DeleteAdvertisementsService deleteAdvertisementsService = new DeleteAdvertisementsService();
            try{
              await deleteAdvertisementsService.deleteAdvertisement(advertisement.advertisementID.toString());
              await Alert(
                context: context,
                title: "Advertisement deleted",
                buttons: [
                  DialogButton(
                    child: Text(
                      "Ok",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    width: 120,
                  ),
                ],
              ).show();
              Navigator.pushReplacementNamed(context, '/catalog');
            } catch (e){
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
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Text("Delete advertisement", style: TextStyle(color: Colors.white)),
        ));
    Container bottomContent;
    if(user.getUserName()==advertisement.createdBy) {
      bottomContent = Container(
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        // color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            children: <Widget>[
              bottomContentText,
              callButton,
              mailButton,
              reportButton,
              deleteButton
            ],
          ),
        ),
      );
    } else{
      bottomContent = Container(
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        // color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            children: <Widget>[
              bottomContentText,
              callButton,
              mailButton,
              reportButton
            ],
          ),
        ),
      );
    }
    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
