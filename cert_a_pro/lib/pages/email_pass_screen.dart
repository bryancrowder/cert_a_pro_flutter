import 'package:cert_a_pro/pages/landing_page.dart';
import 'package:cert_a_pro/providers/auth_provider.dart';
import 'package:cert_a_pro/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailPasswordScreen extends StatelessWidget {
  const EmailPasswordScreen({super.key});
  static const routeName = '/email-pass-page';

  @override
  Widget build(BuildContext context) {
    //Navigator.pop(context);
    return Consumer<AuthProvider>(builder: (context, model, _) {
      return StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        if (model.authType == AuthType.signUp)
                          CustomTextField(
                              controller: model.userNameController,
                              iconData: Icons.person,
                              hintText: "User Name"),
                        CustomTextField(
                            controller: model.emailController,
                            iconData: Icons.email,
                            hintText: "Email"),
                        CustomTextField(
                            controller: model.passwordxController,
                            iconData: Icons.password,
                            hintText: "Password"),
                        TextButton(
                            onPressed: () => {model.authenticate()},
                            child: model.authType == AuthType.signUp
                                ? const Text("Sign Up")
                                : const Text("Sign In")),
                        TextButton(
                            onPressed: () => {model.setAuthType()},
                            child: model.authType == AuthType.signUp
                                ? const Text("Already have an account")
                                : const Text("Create Account")),
                        if (model.authType == AuthType.signIn)
                          TextButton(
                              onPressed: () => {model.resetPassword(context)},
                              child: const Text("Reset Password"))
                      ])),
                ),
              );
            } else {
              return const LandingPage();
            }
          });
    });
  }
}
