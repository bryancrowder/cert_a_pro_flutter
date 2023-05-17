// ignore_for_file: unused_field

import 'package:cert_a_pro/pages/exam_setup_page.dart';
import 'package:cert_a_pro/providers/certification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CertificationPage extends StatefulWidget {
  const CertificationPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/certification-page';

  @override
  State<CertificationPage> createState() => _CertificationPageState();
}

class _CertificationPageState extends State<CertificationPage> {
var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
        Provider.of<Certifications>(context).getCertifications()
            //.getCategories()
            .then((_) => _isLoading = false);
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final categoryID = ModalRoute.of(context)?.settings.arguments as String;

    final certs = Provider.of<Certifications>(context).findByID(categoryID);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Certifications"),
        ),
        body: ListView.builder(
            itemCount: certs.length, // Replace with the number of items in your list
            itemBuilder: (ctx, i) => 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(20),
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: const Color.fromRGBO(185,237,221,1.000),
                          child:
                              Text(certs[i].abbreviation),
                        ),
                        title: Text(
                            '${certs[i].title}',
                            style: const TextStyle(
                              fontSize: 23.0,)),
                        subtitle:
                            Text(certs[i].description,
                            style:const TextStyle(
                              fontSize: 18.0,),),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.of(context)
                          .pushNamed(ExamSetupPage.routeName, arguments: certs[i].id);
                        },
                      ),
                                  ),
                  )));
  }
}
