import 'package:cert_a_pro/providers/category_provider.dart';
import 'package:cert_a_pro/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CategoryGrid extends StatefulWidget {
  const CategoryGrid({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}



class _CategoryGridState extends State<CategoryGrid> {
var _isInit = true;
  var _isLoading = false;


  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
        Provider.of<Categories>(context)
            .getCategories()
            .then((_) => _isLoading = false);
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }




  @override
  Widget build(BuildContext context) {
    final category = Provider.of<Categories>(context);
    final categories = category.items;
    return _isLoading ?
      const Center(child: CircularProgressIndicator(),) :
      GridView.builder(
      padding: const EdgeInsets.all(20.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3/ 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: categories[i],
        child: const CategoryItem(),
      ),
      itemCount: categories.length,
    );
  }
}
