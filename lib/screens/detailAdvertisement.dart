import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappservice/models/shortAdvertisementModel.dart';

class DetailPage extends StatelessWidget {
  final ShortAdvertisements advertisement;

  DetailPage(this.advertisement);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(advertisement.title),
      ),
    );
  }
}
