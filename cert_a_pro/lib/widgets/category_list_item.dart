import 'package:cert_a_pro/providers/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/admin/category_edit.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<Category>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          leading: Consumer<Category>(
              builder: (ctx, product, _) => IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CategoryEdit.routeName);
                    },
                    color: Theme.of(context).colorScheme.secondary,
                  )),
          backgroundColor: Colors.black12,
        ),
          child: 
          Image.network(
          category.img,
           fit: BoxFit.cover,
          ),
        ),
    );
  }
}
