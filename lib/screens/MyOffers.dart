import 'package:flutter/material.dart';
import 'package:flutterappservice/models/user.dart';
import 'package:flutterappservice/screens/addAdvertisement.dart';
import 'package:flutterappservice/screens/login.dart';
import 'package:flutterappservice/services/getAdvertisementsService.dart';
import 'package:flutterappservice/widgets/navbar.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'detailAdvertisement.dart';

class Offers extends StatelessWidget {
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
                      )
                    ],
                  ).show();
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => MyLogin()));
                }
              },
            ),
          ),
        ],
      ),
      body: new MyOffers(),
    );
  }
}

class MyOffers extends StatefulWidget {
  MyOffers();

  @override
  _MyOffers createState() => new _MyOffers();
}

class _MyOffers extends State<MyOffers> {
  final GetAdvertisementsService getAdvertisementsService =
  GetAdvertisementsService();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: FutureBuilder(
          future: getAdvertisementsService.getPosts(),
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
                    subtitle: Text(truncate(snapshot.data[index].description.toString(),80)),
                    trailing: Text(snapshot.data[index].city+'\n'+snapshot.data[index].reward.toString()+" zł",textAlign: TextAlign.right),
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
  String truncate( String s, int n ){
    if (s.length <= n) return s;
    String subString = s.substring(0, n-1);
    String subString2 = subString.replaceAll(RegExp('\n'), ' ');
    return subString2+'...';
  }
}
