import 'package:cert_a_pro/pages/admin/certification_add.dart';
import 'package:cert_a_pro/pages/admin/certification_edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/certification_provider.dart';
import '../../widgets/drawer.dart';

class CertificationList extends StatefulWidget {
  const CertificationList({super.key});
  static const routeName = '/certification_list';

  @override
  State<CertificationList> createState() => _CertificationListState();
}

class _CertificationListState extends State<CertificationList> {
  @override
  void didChangeDependencies() {
    Provider.of<Certifications>(context).getCertifications();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final certs = Provider.of<Certifications>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Certifications"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CertificationAdd.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
          itemCount: certs
              .items.length, // Replace with the number of items in your list
          itemBuilder: (ctx, i) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(20),
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor:
                          const Color.fromRGBO(185, 237, 221, 1.000),
                      child: Text(certs.items[i].abbreviation),
                    ),
                    title: Text(certs.items[i].title,
                        style: const TextStyle(
                          fontSize: 23.0,
                        )),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(CertificationEdit.routeName, arguments:certs.items[i].id);
                    },
                  ),
                ),
              )),
      drawer: const AppDrawer(),
    );
  }
}
