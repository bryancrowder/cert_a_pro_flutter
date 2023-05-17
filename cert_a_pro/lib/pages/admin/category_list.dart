
import 'package:cert_a_pro/widgets/category_list_grid.dart';
import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import 'category_edit.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  static const routeName = '/category_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories"),
      actions: <Widget> [
        IconButton(onPressed: 
        () {
          Navigator.of(context).pushNamed(CategoryEdit.routeName);
        }, 
        icon: const Icon(Icons.add))
      ],),
      body: const Center(
        child: CategoryListGrid()
      ),
      drawer: const AppDrawer(),
    );
  }
}
