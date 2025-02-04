import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_input_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomInputField(
          title: 'Username',
          hint: 'What Shall We Call You?',
          //controller: emailController,
        ),
        CustomInputField(
          title: 'Email Address',
          hint: 'Your wizardly email address.',
          //controller: emailController,
          textType: TextInputType.emailAddress,
        ),
        CustomInputField(
          title: 'Password',
          hint: 'At least 8 characters, no spoilers!',
          isPassword: true,
          textType: TextInputType.visiblePassword,
          //controller: passwordController,
        ),
        CustomInputField(
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
