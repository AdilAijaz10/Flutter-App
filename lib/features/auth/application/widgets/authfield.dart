import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  final TextInputType? inputType;
  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (value) {
      if(value!.isEmpty){
        return "$hintText is missing!";
      }
      return null;
      },
      obscureText:  isObscureText,
      // obscuringCharacter: "*",
    );
  }
}