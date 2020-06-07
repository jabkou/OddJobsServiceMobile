import 'package:flutter/material.dart';
import 'package:flutterappservice/models/user.dart';
import 'package:flutterappservice/screens/addAdvertisement.dart';
import 'package:flutterappservice/screens/login.dart';
import 'package:flutterappservice/services/getAdvertisementsService.dart';
import 'package:flutterappservice/widgets/navbar.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'detailAdvertisement.dart';
import 'filterAdvertisements.dart';

// ignore: must_be_immutable
class Catalog extends StatelessWidget {
  String city;
  String category;
  String workingHour;
  String contractType;
  String user;

  Catalog(
      {this.city,
      this.category,
      this.workingHour,
      this.contractType,
      this.user});

  final GetAdvertisementsService getAdvertisementsService =
      GetAdvertisementsService();

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
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.filter_vintage),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => FilterAdvertisementPage()));
              },
            ),
          ),
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                if (user.isLogin()) {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => AddAdvertisementPage()));
                } else {
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
            ),
          )
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: getAdvertisementsService.getPosts(
              city: this.city,
              advertisementCategory: this.category,
              workingHours: this.workingHour,
              contractType: this.contractType,
              user: this.user),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                  child: Center(
                child: Text("Loading..."),
              ));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://randomuser.me/api/portraits/men/75.jpg'),
                    ),
                    title: Text(truncate(snapshot.data[index].title, 45)),
                    subtitle: Text(truncate(
                        snapshot.data[index].description.toString(), 80)),
                    trailing: Text(
                        snapshot.data[index].city +
                            '\n' +
                            snapshot.data[index].reward.toString() +
                            " zł",
                        textAlign: TextAlign.right),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(snapshot.data[index])));
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  String truncate(String s, int n) {
    if (s.length <= n) return s;
    String subString = s.substring(0, n - 1);
    String subString2 = subString.replaceAll(RegExp('\n'), ' ');
    return subString2 + '...';
  }
}
