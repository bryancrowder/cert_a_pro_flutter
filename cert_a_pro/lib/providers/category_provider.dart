import 'dart:io';

import 'package:cert_a_pro/providers/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../keys.dart';

class Categories with ChangeNotifier {
  bool categoriesRetrieved = false;
  List<Category> _categories = [];

  Category findById(String id) {
    return _categories.firstWhere((product) => product.id == id);
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> getCategories() async {
    try {
      List<Category> cats = [];
      await firebaseFirestore
          .collection("categories")
          .get()
          .then((category) async {
        for (var cat in category.docs) {
          cats.add(
              Category(id: cat.id, title: cat["title"], img: cat["image"]));
        }
      });
      _categories = cats;
      categoriesRetrieved = true;
      notifyListeners();
    } catch (e) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
        content: Text("Something went wrong trying to get the categories..."),
        backgroundColor: Colors.red,
      ));
    }
  }

  addCategory(String name, File img) async {
    String imageURL;
    try {
      final ref = FirebaseStorage.instance.ref().child(name);
      await ref.putFile(img);
      imageURL = await ref.getDownloadURL();
      firebaseFirestore
          .collection("categories")
          .add({"title": name, "image": imageURL});
    } catch (exception) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
        content: Text("Something went wrong..."),
        backgroundColor: Colors.red,
      ));
    }
  }

  List<Category> get items {
    return [..._categories];
  }
}
