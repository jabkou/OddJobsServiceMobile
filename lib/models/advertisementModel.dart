import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class Advertisement {
  final int advertisementID;
  final String title;
  final String description;
  final String category;
  final List<int> dateTime;
  final bool featured;
  final List<String> photos;

  Advertisement({
    @required this.advertisementID,
    @required this.title,
    @required this.description,
    @required this.category,
    @required this.dateTime,
    @required this.featured,
    @required this.photos
  });

  factory Advertisement.fromJson(Map<String, dynamic> json) {
    var tempDateTime = json['dateTime'];
    var tempPhotos = json['photos'];
    return Advertisement(
        advertisementID: json['advertisementID'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        category: json['category'] as String,
        dateTime: new List<int>.from(tempDateTime),
        featured: json['featured'] as bool,
        photos: new List<String>.from(tempPhotos)
    );
  }
}