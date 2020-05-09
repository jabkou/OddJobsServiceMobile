import 'package:flutter/material.dart';
import 'package:flutterappservice/services/getAdvertisementsService.dart';
import 'package:flutterappservice/widgets/navbar.dart';

import 'detailAdvertisement.dart';

class Catalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: new MyCatalog(),
    );
  }
}

class MyCatalog extends StatefulWidget {
  MyCatalog();

  @override
  _MyCatalog createState() => new _MyCatalog();
}

class _MyCatalog extends State<MyCatalog> {
  final GetAdvertisementsService smallAdvertisementsService =
      GetAdvertisementsService();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: FutureBuilder(
          future: smallAdvertisementsService.getPosts(),
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
                    title: Text(snapshot.data[index].title),
                    subtitle: Text(snapshot.data[index].description.toString()),
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
}
