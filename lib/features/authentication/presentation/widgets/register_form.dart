// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_input_field.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController confirmPassword;

  const RegisterForm({
    super.key,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInputField(
          title: 'Email Address',
          hint: 'Your wizardly email address.',
          controller: email,
          textType: TextInputType.emailAddress,
          validator: (txt) {
            if (txt == null || txt.isEmpty) {
              return "Hello? Anybody home? This field feels lonely!";
            }
            // You can add more checks like email regex if needed
            return null;
          },
        ),
        CustomInputField(
          title: 'Password',
          hint: 'At least 8 characters, no spoilers!',
          isPassword: true,
          textType: TextInputType.visiblePassword,
          controller: password,
          validator: (txt) {
            if (txt == null || txt.isEmpty) {
              return "Hello? Anybody home? This field feels lonely!";
            }
            if (txt != confirmPassword.text) {
              return "Oops! These two just aren’t vibing.";
            }
            return null;
          },
        ),
        CustomInputField(
          title: 'Confirm Password',
          hint: 'Repeat your secret phrase',
          isPassword: true,
          textType: TextInputType.visiblePassword,
          controller: confirmPassword,
          validator: (txt) {
            if (txt == null || txt.isEmpty) {
              return "Hello? Anybody home? This field feels lonely!";
            }
            if (txt != password.text) {
              return "Oops! These two just aren’t vibing.";
            }
            return null;
          },
        ),
      ],
    );
  }
}
