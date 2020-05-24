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
  final String city;
  final String createdBy;
  final String workingHours;
  final String contractType;
  final int reward;
  final List<String> photos;

  Advertisement(
      {@required this.advertisementID,
      @required this.title,
      @required this.description,
      @required this.category,
      @required this.dateTime,
      @required this.featured,
      @required this.city,
      @required this.createdBy,
      @required this.workingHours,
      @required this.contractType,
      @required this.reward,
      @required this.photos});

  factory Advertisement.fromJson(Map<String, dynamic> json) {
    var tempDateTime = json['dateTime'];
    var tempPhotos = json['photos'];
    return Advertisement(
        advertisementID: json['advertisementID'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        category: json['advertisementCategory'] as String,
        dateTime: new List<int>.from(tempDateTime),
        featured: json['featured'] as bool,
        city: json['city'] as String,
        createdBy: json['createdBy'] as String,
        workingHours: json['workingHours'] as String,
        contractType: json['contractType'] as String,
        reward: json['reward'] as int,
        photos: new List<String>.from(tempPhotos));
  }
}
