import 'package:flutter/material.dart';
import 'package:flutter_app/Core/Theme/theme.dart';
// import 'package:flutter_app/features/auth/application/pages/signup_page.dart';
import 'package:flutter_app/features/auth/application/pages/login_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.darkTheme,
      // home: const SignUpPage(),
      home: const LogInPage(),
    );
  }
}