import 'package:flutter/material.dart';

class Certification with ChangeNotifier {
  final String id;
  final String title;
  final String abbreviation;
  final String description;
  final String categoryID;

  Certification({
    required this.id,
    required this.title,
    required this.abbreviation,
    required this.description,
    required this.categoryID,
  });
}
