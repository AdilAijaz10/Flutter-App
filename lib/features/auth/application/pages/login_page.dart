import 'package:flutter/material.dart';
import 'package:flutter_app/Core/Theme/app_pallet.dart';
import 'package:flutter_app/features/auth/application/widgets/authfield.dart';
import 'package:flutter_app/features/auth/application/widgets/auth_gradient_button.dart';
import 'package:flutter_app/features/auth/application/pages/signup_page.dart';
class LogInPage extends StatefulWidget {
  static route()=> MaterialPageRoute(
    builder: (context) => const LogInPage(),
  );
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
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
                'Sign In',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              AuthField(hintText: 'Email', controller: emailcontroller),
              const SizedBox(height: 15),
              AuthField(hintText: 'Password', controller: passwordcontroller, isObscureText: true),
              const SizedBox(height: 20),
              const AuthGradientButton(buttonText: "Sign In"),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, SignUpPage.route());
                },
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Sign Up',
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
