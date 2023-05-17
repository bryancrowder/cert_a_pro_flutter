import 'package:cert_a_pro/providers/certification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/category_provider.dart';

class CertificationAdd extends StatefulWidget {
  const CertificationAdd({super.key});

  static const routeName = '/certification_add';

  @override
  State<CertificationAdd> createState() => _CertificationAddState();
}

final _titleController = TextEditingController();
final _abbreviationController = TextEditingController();
final _descriptionController = TextEditingController();
var _categoryItem = "";
final _formKey = GlobalKey<FormState>();

class _CertificationAddState extends State<CertificationAdd> {
  Future<void> _saveForm() async {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
    try {
      await Provider.of<Certifications>(context, listen: false)
          .addCertification(_titleController.text, _abbreviationController.text,
              _descriptionController.text, _categoryItem);
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
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final categoryItem = Provider.of<Categories>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text("Certification Add")),
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
                  child: const Text('Add Certification'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
