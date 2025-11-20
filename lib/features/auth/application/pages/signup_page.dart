import 'package:flutter/material.dart';
import 'package:flutter_app/Core/Theme/app_pallet.dart';
import 'package:flutter_app/features/auth/application/widgets/authfield.dart';
import 'package:flutter_app/features/auth/application/widgets/auth_gradient_button.dart';
import 'package:flutter_app/features/auth/application/pages/login_page.dart';
class SignUpPage extends StatefulWidget {
  static route()=> MaterialPageRoute(
    builder: (context) => const SignUpPage(),
  );
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final namecontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    namecontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _formKey.currentState?.validate();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Up',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              AuthField(hintText: 'Name', controller: namecontroller),
              const SizedBox(height: 15),
              AuthField(hintText: 'Email', controller: emailcontroller),
              const SizedBox(height: 15),
              AuthField(hintText: 'Password', controller: passwordcontroller, isObscureText: true),
              const SizedBox(height: 20),
              const AuthGradientButton(buttonText: "Sign Up"),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, LogInPage.route());
                },
                child: RichText(
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Sign In',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppPallete.gradient2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
