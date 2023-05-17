import 'package:cert_a_pro/pages/admin/category_list.dart';
import 'package:cert_a_pro/pages/admin/certification_list.dart';
import 'package:flutter/material.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        AppBar(
          title: const Text("Admin Panel"),
          automaticallyImplyLeading: false,
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text("Home"),
          onTap: () {
            Navigator.of(context).pushReplacementNamed("/landing-page");
          },
        ),
        ListTile(
          leading: const Icon(Icons.category),
          title: const Text("Categories"),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(CategoryList.routeName);
          },
        ),
 
        ListTile(
          leading: const Icon(Icons.question_answer),
          title: const Text("Certifications"),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(CertificationList.routeName);
          },
          
        ),
      ]),
    );
  }
}