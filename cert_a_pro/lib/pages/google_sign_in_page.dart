import 'package:cert_a_pro/pages/landing_page.dart';
import 'package:cert_a_pro/providers/auth_provider.dart';
import 'package:cert_a_pro/widgets/auth_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class GoogleSignInPage extends StatelessWidget {
  const GoogleSignInPage({super.key});
  static const routeName = "/google-sign-in-page";
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const LandingPage();
          } else {
            return Scaffold(
              appBar: AppBar(),
              body: Consumer<AuthProvider>(builder: (context, model, _) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: AuthButton(
                      iconData: FontAwesomeIcons.google,
                      title: " Google",
                      onTap: () {
                        model.signInWithGoogle();
                      },
                    ),
                  ),
                );
              }),
            );
          }
        });
  }
}
