import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_input_field.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;

  const LoginForm({super.key, required this.email, required this.password});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInputField(
          title: 'Email Address',
          hint: 'Where should we send the bookmarks?',
          controller: email,
          textType: TextInputType.emailAddress,
          validator: (txt) {
            if (txt == null || txt.isEmpty) {
              return "Psst... we need this to find your bookshelf!";
            }
            if (!txt.contains('@')) {
              return "That doesn't look like a real owl post address!";
            }
            return null;
          },
        ),
        CustomInputField(
          title: 'Password',
          hint: 'Your secret chapter code',
          isPassword: true,
          textType: TextInputType.visiblePassword,
          controller: password,
          validator: (txt) {
            if (txt == null || txt.isEmpty) {
              return "You'll need the magic words to enter!";
            }
            if (txt.length < 6) {
              return "This spell seems a bit short... try longer!";
            }
            return null;
          },
        ),
      ],
    );
  }
}
