// ignore_for_file: unused_element

import 'package:cert_a_pro/pages/admin/question_edit.dart';
import 'package:cert_a_pro/pages/admin/question_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/category_provider.dart';
import '../../providers/certification.dart';
import '../../providers/certification_provider.dart';
import '../../providers/question.dart';

class CertificationEdit extends StatefulWidget {
  const CertificationEdit({super.key});

  @override
  State<CertificationEdit> createState() => _CertificationEditState();

  static const routeName = '/certification_edit';
}

var _id = "";
final _titleController = TextEditingController();
final _abbreviationController = TextEditingController();
final _descriptionController = TextEditingController();
var _categoryItem = "";
final _formKey = GlobalKey<FormState>();
List <Question> _questions = [];

class _CertificationEditState extends State<CertificationEdit> {
  Future<void> _saveForm() async {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
    try {
      await Provider.of<Certifications>(context, listen: false)
          .setCertification(
              _id,
              _titleController.text,
              _abbreviationController.text,
              _descriptionController.text,
              _categoryItem);
    } catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("An Error has Occured"),
                content: const Text("Something went wrong"),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text("Okay"))
                ],
              ));
    } finally {
      Navigator.of(context).pop();
    }

    //}
  }

  @override
  void didChangeDependencies() {
    String incomingcertID =
        ModalRoute.of(context)?.settings.arguments as String;
    Certification cert = Provider.of<Certifications>(context, listen: false)
        .findCertByID(incomingcertID);
    _id = cert.id;
    _titleController.text = cert.title;
    _abbreviationController.text = cert.abbreviation;
    _descriptionController.text = cert.description;
    _categoryItem = cert.categoryID;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final certID = ModalRoute.of(context)?.settings.arguments as String;
    final categoryItem = Provider.of<Categories>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Certification Edit"),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(QuestionEdit.routeName, arguments: certID);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration:
                    const InputDecoration(labelText: "Certification Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Category Title';
                  }
                  return null;
                },
                controller: _titleController,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(labelText: "Abbreviation"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an abbreviation';
                  }
                  return null;
                },
                controller: _abbreviationController,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(labelText: "Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                controller: _descriptionController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: DropdownButtonFormField(
                  value: _categoryItem,
                  style: const TextStyle(color: Colors.black),
                  dropdownColor: Theme.of(context).colorScheme.primary,
                  decoration: const InputDecoration(labelText: "Category"),
                  items: categoryItem.items
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(e.title),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _categoryItem = value!;
                    });
                  },
                  validator: (value) => value == null ? 'Field Required' : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Adding Certification')),
                      );
                      _saveForm();
                      _titleController.clear();
                      _abbreviationController.clear();
                      _descriptionController.clear();
                    }
                  },
                  child: const Text('Save Certification'),
                ),
              ),
              
              QuestionList(certID: certID),
            ],
          ),
        ),
      ),
    );
  }
}
