import 'package:flutter/material.dart';
import 'package:flutter_app/Core/Theme/app_pallet.dart';
import 'package:flutter_app/Core/di/service_locator.dart';
import 'package:flutter_app/features/auth/application/controller/login_controller.dart';
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
  final tenantIdController = TextEditingController(text: '0');
  late final LoginController _loginController;
  LoginStatus _lastStatus = LoginStatus.initial;

  @override
  void initState() {
    super.initState();
    _loginController = sl<LoginController>()..addListener(_onStateChanged);
  }

  @override
  void dispose() {
    _loginController
      ..removeListener(_onStateChanged)
      ..dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    tenantIdController.dispose();
    super.dispose();
  }
  
  void _onStateChanged() {
    final currentState = _loginController.state;
    if (!mounted || currentState.status == _lastStatus) return;
    _lastStatus = currentState.status;
    if (currentState.status == LoginStatus.failure && currentState.message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(currentState.message!),
          backgroundColor: Colors.red,
        ),
      );
    } else if (currentState.status == LoginStatus.success) {
      final token = currentState.data?.token;
      final tokenPreview = token == null
          ? ''
          : token.length > 12
              ? '${token.substring(0, 12)}...'
              : token;
      final snackText = currentState.message ??
          (tokenPreview.isNotEmpty ? 'Login successful ($tokenPreview)' : 'Login successful');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(snackText),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final tenantId = int.tryParse(tenantIdController.text.trim()) ?? 0;
    await _loginController.login(
      email: emailcontroller.text.trim(),
      password: passwordcontroller.text,
      tenantId: tenantId,
    );
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _loginController,
      builder: (context, _) {
        final isLoading = _loginController.state.status == LoginStatus.loading;
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
                  AuthField(
                    hintText: 'Password',
                    controller: passwordcontroller,
                    isObscureText: true,
                  ),
                  const SizedBox(height: 15),
                  AuthField(
                    hintText: 'Tenant ID',
                    controller: tenantIdController,
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  AuthGradientButton(
                    buttonText: "Sign In",
                    isLoading: isLoading,
                    onPressed: isLoading ? null : _submit,
                  ),
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
    );
  }
}
