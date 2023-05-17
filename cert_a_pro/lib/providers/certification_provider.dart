import 'package:cert_a_pro/providers/certification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../keys.dart';

class Certifications with ChangeNotifier {
  List<Certification> _certifications = [];

  List<Certification> get items {
    return [..._certifications];
  }

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  addCertification(String title, String abbreviation, String description,
      String categoryID) async {
    try {
      firebaseFirestore.collection("certifications").add({
        "title": title,
        "abbreviation": abbreviation,
        "description": description,
        "categoryID": categoryID
      });
    } catch (exception) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
        content: Text("Something went wrong..."),
        backgroundColor: Colors.red,
      ));
    }
  }

setCertification(String id, String title, String abbreviation, String description,
      String categoryID) async {
    try {
      firebaseFirestore.collection("certifications").doc(id).set({
        "title": title,
        "abbreviation": abbreviation,
        "description": description,
        "categoryID": categoryID
      });
    } catch (exception) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
        content: Text("Something went wrong..."),
        backgroundColor: Colors.red,
      ));
    }
  }


  Future<void> getCertifications() async {
    try {
      List<Certification> certs = [];
      await firebaseFirestore
          .collection("certifications")
          .get()
          .then((certifications) async {
        for (var cert in certifications.docs) {
          certs.add(Certification(
            id: cert.id,
            title: cert["title"],
            abbreviation: cert["abbreviation"],
            categoryID: cert["categoryID"],
            description: cert["description"],
          ));
        }
      });
      _certifications = certs;
      //categoriesRetrieved = true;
      notifyListeners();
    } catch (e) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
        content: Text("Something went wrong trying to get the categories..."),
        backgroundColor: Colors.red,
      ));
    }
  }

  findByID(id) {
    return _certifications.where((cert) => cert.categoryID == id).toList();
  }

  Certification findCertByID(id) {
    return _certifications.firstWhere((cert) => cert.id == id);
  }
}
