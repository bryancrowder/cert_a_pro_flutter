import 'package:flutter/material.dart';


class Category with ChangeNotifier {
  final String id;
  final String title;
  final String img;

  Category({
    required this.id,
    required this.title,
    required this.img
  });
}
