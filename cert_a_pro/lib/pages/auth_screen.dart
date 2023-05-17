import 'package:cert_a_pro/pages/email_pass_screen.dart';
import 'package:cert_a_pro/widgets/auth_button.dart';
import 'package:cert_a_pro/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'google_sign_in_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
static const routeName = '/auth-page';
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoVideo(),
            const Text(
              "Select Sign In Method:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            AuthButton(
              iconData: Icons.email,
              title: " Email/Password",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const EmailPasswordScreen()));
              },
            ),
             AuthButton(
              iconData: FontAwesomeIcons.google,
              title: " Sign in with Google",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const GoogleSignInPage()));
              },
            ),

            //-----------------------------------------------
            //For future relases I am keeping this code here.
            //-----------------------------------------------

            // AuthButton(
            //   iconData: FontAwesomeIcons.microsoft,
            //   title: " Sign in with Microsoft",
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (_) => const EmailPasswordScreen()));
            //   },
            // ),
            // AuthButton(
            //   iconData: FontAwesomeIcons.facebook,
            //   title: " Sign in with Facebook",
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (_) => const EmailPasswordScreen()));
            //   },
            // ),
          ],
        ),
      )),
    );
  }
}
