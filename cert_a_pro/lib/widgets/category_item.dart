import 'package:cert_a_pro/pages/certification_page.dart';
import 'package:cert_a_pro/providers/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<Category>(context, listen: false);
    return  ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
               .pushNamed(CertificationPage.routeName, arguments: category.id);
          },
          child: 
          Image.network(
          category.img,
          fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}