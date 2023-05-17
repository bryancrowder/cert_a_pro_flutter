import 'dart:async';

import 'package:cert_a_pro/keys.dart';
import 'package:cert_a_pro/widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordxController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  AuthType _authType = AuthType.signIn;
  AuthType get authType => _authType;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  setAuthType() {
    _authType =
        _authType == AuthType.signIn ? AuthType.signUp : AuthType.signIn;
    notifyListeners();
  }

  authenticate() async {
    UserCredential userCredential;
    try {
      if (_authType == AuthType.signUp) {
        userCredential = await firebaseAuth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordxController.text);
        await userCredential.user!.sendEmailVerification();
        await firebaseFirestore
            .collection("users")
            .doc(userCredential.user!.uid)
            .set({
          "uid": userCredential.user!.uid,
          "email": userCredential.user!.email,
          "user_name": userNameController.text
        });
        notifyListeners();
      }
      if (_authType == AuthType.signIn) {
        userCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordxController.text);
        notifyListeners();
      }
    } on FirebaseAuthException catch (error) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
        content: Text(error.code),
        backgroundColor: Colors.red,
      ));
    } catch (error) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
          content: Text(error.toString()), backgroundColor: Colors.red));
    }
  }

  bool? emailVerified;

  updateEmailVerificationState() async {
    emailVerified = firebaseAuth.currentUser!.emailVerified;

    if (!emailVerified!) {
      Timer.periodic(const Duration(seconds: 3), (timer) async {
        await firebaseAuth.currentUser!.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user!.emailVerified) {
          emailVerified = user.emailVerified;
          timer.cancel();
          notifyListeners();
        }
      });
    }
  }

  TextEditingController resetEmailController = TextEditingController();

  resetPassword(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            title: const Text("Enter your email"),
            content: CustomTextField(
              iconData: Icons.email,
              controller: resetEmailController,
              hintText: 'Enter Email',
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context).pop();
                    try {
                      await firebaseAuth.sendPasswordResetEmail(
                          email: resetEmailController.text);
                      Keys.scaffoldMessengerKey.currentState!
                          .showSnackBar(const SnackBar(
                        content: Text("Email Sent Successfully"),
                        backgroundColor: Colors.green,
                      ));
                      navigator;
                    } catch (exception) {
                      Keys.scaffoldMessengerKey.currentState!
                          .showSnackBar(const SnackBar(
                        content: Text("Something went wrong Email not sent"),
                        backgroundColor: Colors.red,
                      ));
                      navigator;
                    }
                  },
                  child: const Text("Submit"))
            ],
          );
        });
  }

  GoogleSignIn googleSignIn = GoogleSignIn();

  signInWithGoogle() async {
    
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      try {
        //UserCredential userCredential;
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await firebaseAuth.signInWithCredential(authCredential);
 await firebaseFirestore
            .collection("users")
            .doc(googleSignInAccount.id)
            .set({
          "uid": googleSignInAccount.id,
          "email": googleSignInAccount.email,
          "user_name": googleSignInAccount.displayName
        });

      } on FirebaseAuthException catch (e) {
        Keys.scaffoldMessengerKey.currentState!.showSnackBar(
            SnackBar(content: Text(e.message!), backgroundColor: Colors.red));
      }
    } else {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(const SnackBar(
          content: Text("Account not Selected"), backgroundColor: Colors.red));
    }
  }

  logOut() async {
    try {
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
      notifyListeners();
    } catch (error) {
      Keys.scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
          content: Text(error.toString()), backgroundColor: Colors.red));
    }
  }
}

enum AuthType { signUp, signIn }
