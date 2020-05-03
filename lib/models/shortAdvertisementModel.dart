import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class ShortAdvertisements {
  final int id;
  final String title;
  final String description;
  final String category;

  ShortAdvertisements({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.category,
  });

  factory ShortAdvertisements.fromJson(Map<String, dynamic> json) {
    return ShortAdvertisements(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        category: json['category'] as String,
    );
  }
}