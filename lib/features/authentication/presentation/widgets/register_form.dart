import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_input_field.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  const RegisterForm({super.key, required this.email, required this.password});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomInputField(
          title: 'Username',
          hint: 'What Shall We Call You?',
          //controller: emailController,
        ),
        CustomInputField(
          title: 'Email Address',
          hint: 'Your wizardly email address.',
          controller: email,
          textType: TextInputType.emailAddress,
          validator: (txt) {
            return "Hello? Anybody home? This field feels lonely!";
          },
        ),
        CustomInputField(
          title: 'Password',
          hint: 'At least 8 characters, no spoilers!',
          isPassword: true,
          textType: TextInputType.visiblePassword,
          controller: password,
        ),
        const CustomInputField(
          title: 'Confirm Password',
          hint: 'Repeat your secret phrase',
          isPassword: true,
          textType: TextInputType.visiblePassword,
          //controller: passwordController,
        ),
      ],
    );
  }
}
