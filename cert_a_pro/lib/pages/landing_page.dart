import 'package:cert_a_pro/providers/auth_provider.dart';
import 'package:cert_a_pro/providers/category_provider.dart';
import 'package:cert_a_pro/widgets/category_grid.dart';
import 'package:cert_a_pro/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: constant_identifier_names
enum FilterOptions { Favorites, All }

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);
  static const routeName = "/landing-page";

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // ignore: prefer_final_fields
  var _isInit = true;
  // ignore: unused_field
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.updateEmailVerificationState();

    if (_isInit) {
      setState(() {
        _isLoading = true;
        Provider.of<Categories>(context)
            .getCategories()
            .then((_) => _isLoading = false);
      });
      _isInit = false;
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, model, _) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Welcome",
            ),
            actions: <Widget>[
              PopupMenuButton(
                  onSelected: (String choice) {
                    if (choice == "logOut") {
                      model.logOut();
                    }
                  },
                  itemBuilder: (_) => [
                        const PopupMenuItem(
                            value: "logOut", child: Text("Log Out"))
                      ])
            ],
          ),
          drawer: const AppDrawer(),
          body: model.emailVerified ?? false
              ? const CategoryGrid()
              : const Center(
                  child: Text("Email Not Verified"),
                ));
    });
  }
}
