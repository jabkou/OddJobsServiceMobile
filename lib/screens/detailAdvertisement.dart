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
    );
  }
}
