import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappservice/models/advertisementModel.dart';

class DetailPage extends StatelessWidget {
  final Advertisement advertisement;

  DetailPage(this.advertisement);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(advertisement.title),
        ),
        body: Column(
          children: <Widget>[
            Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.cyan, Colors.white])),
                child: Image.network(
                    ("https://randomuser.me/api/portraits/men/75.jpg"))),
            Container(
              child: Text(advertisement.city+'\n'+advertisement.category+'\n'+advertisement.contractType+'\n'+advertisement.workingHours+'\n'+advertisement.reward.toString()),
            ),
            Container(
              child: Text(advertisement.description),
            )
          ],
        ));
  }
}
