import 'dart:io';

import 'package:cert_a_pro/providers/category.dart';
import 'package:cert_a_pro/providers/category_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryEdit extends StatefulWidget {
  const CategoryEdit({super.key});
  static const routeName = '/category_edit';

  @override
  State<CategoryEdit> createState() => _CategoryEditState();
}

class _CategoryEditState extends State<CategoryEdit> {
  // ignore: prefer_final_fields, unused_field
  var _editedCategory = Category(id: "", title: "" ,img: "");
  PlatformFile? pickedFile;
  String title = "";

  var _isInit = true;
  // ignore: unused_field
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final categoryID = ModalRoute.of(context)!.settings.arguments as String;
        _editedCategory = Provider.of<Categories>(context, listen: false)
            .findById(categoryID);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  final _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState?.validate();
    setState(() {
      _isLoading = true;
    });

    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();
    //if (_editedCategory.id != "") {
    //   try{
    //     // await Provider.of<Categories>(context, listen: false)
    //     //   .updateProduct(_editedCategory.id, _editedCategory);
    //     //   setState(() {
    //     //     Navigator.of(context).pop();
    //     //   });
    //   }
    //   catch(error) {
    //     await showDialog(
    //         context: context,
    //         builder: (ctx) => AlertDialog(
    //               title: const Text("An Error has Occured"),
    //               content: const Text("Something went wrong"),
    //               actions: <Widget>[
    //                 TextButton(
    //                     onPressed: () {
    //                       Navigator.of(ctx).pop();
    //                     },
    //                     child: const Text("Okay"))
    //               ],
    //             ));
    //   }

    // } else {
    try {
      title = _titleController.text;
      // ignore: unused_local_variable
      final File fileForFirebase = File(pickedFile!.path.toString());
      await Provider.of<Categories>(context, listen: false)
          .addCategory(title, fileForFirebase);
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
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
    //}
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    //final test = await FileImage;
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryItem = Provider.of<Categories>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text("Category Add/Edit")),
      //drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(labelText: "Category Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Category Title';
                  }
                  return null;
                },
                controller: _titleController,
              ),
              // ignore: unnecessary_null_comparison
              if (pickedFile != null)
                Expanded(
                  child: Center(child: Text(pickedFile!.name)),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    selectFile();
                  },
                  child: const Text('Upload File'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Adding Category')),
                      );
                      _saveForm();
                      categoryItem.addCategory(
                          _titleController.text, pickedFile as File);
                    }
                  },
                  child: const Text('Add Category'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
