import 'package:flutter/material.dart';
import 'package:litlore/features/authentication/presentation/widgets/register_view_body.dart';


class RegisterView extends StatelessWidget {
  static const routeName = "Register View";
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RegisterViewBody(),
    );
  }
}
