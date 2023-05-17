import 'package:cert_a_pro/keys.dart';
import 'package:cert_a_pro/pages/admin/category_edit.dart';
import 'package:cert_a_pro/pages/admin/certification_add.dart';
import 'package:cert_a_pro/pages/admin/certification_edit.dart';
import 'package:cert_a_pro/pages/admin/certification_list.dart';
import 'package:cert_a_pro/pages/admin/question_edit.dart';
import 'package:cert_a_pro/pages/auth_screen.dart';
import 'package:cert_a_pro/pages/certification_page.dart';
import 'package:cert_a_pro/pages/email_pass_screen.dart';
import 'package:cert_a_pro/pages/exam_setup_page.dart';
import 'package:cert_a_pro/pages/admin/category_list.dart';
import 'package:cert_a_pro/pages/google_sign_in_page.dart';
import 'package:cert_a_pro/pages/landing_page.dart';
import 'package:cert_a_pro/providers/auth_provider.dart';
import 'package:cert_a_pro/providers/category_provider.dart';
import 'package:cert_a_pro/providers/certification_provider.dart';
import 'package:cert_a_pro/providers/exam.dart';
import 'package:cert_a_pro/providers/question.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext ctx) => Categories(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext ctx) => Certifications(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext ctx) => AuthProvider(),
        ),
         ChangeNotifierProvider(
          create: (BuildContext ctx) => Questions(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext ctx) => Exams(),
        ),
      ],
      child: MaterialApp(
        title: 'Cert-A-Pro',
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: Keys.scaffoldMessengerKey,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Color.fromRGBO(185,237,221,1.000)),
          scaffoldBackgroundColor: const Color.fromRGBO(135,203,185,1.000),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromRGBO(87,125,134,1.000),
              ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black
            )),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.cyan)
              .copyWith(primary: const Color.fromRGBO(86,157,170,1.000),
                        secondary: const Color.fromRGBO(87,125,134,1.000)),
          fontFamily: 'Lato',
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const LandingPage();
            } else {
              return const AuthPage();
            }
          },
        ),
        routes: {
          CertificationPage.routeName: (ctx) => const CertificationPage(),
          ExamSetupPage.routeName: (ctx) => const ExamSetupPage(),
          AuthPage.routeName: (ctx) => const AuthPage(),
          EmailPasswordScreen.routeName: (ctx) => const EmailPasswordScreen(),
          GoogleSignInPage.routeName: (ctx) => const GoogleSignInPage(),
          LandingPage.routeName: (ctx) => const LandingPage(),
          CategoryList.routeName: (ctx) => const CategoryList(),
          CategoryEdit.routeName: (ctx) => const CategoryEdit(),
          CertificationList.routeName: (ctx) => const CertificationList(),
          CertificationAdd.routeName: (ctx) => const CertificationAdd(),
          CertificationEdit.routeName: (ctx) => const CertificationEdit(),
          QuestionEdit.routeName: (ctx) => const QuestionEdit(),
        
        },
      ),
    );
  }
}
