import 'package:flutter/material.dart';
import 'package:litlore/core/functions/size_functions.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/app_assets.dart';
import 'package:litlore/core/widgets/app_button_widget.dart';
import 'package:litlore/core/widgets/custom_input_field.dart';
import 'package:litlore/features/authentication/presentation/widgets/custom_container_widget.dart';

class RegisterView extends StatelessWidget {
  static const routeName = "Register View";
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainerWidget(
        containerHeight: height(context) * 0.73,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    "Register",
                    style: MyFonts.headingStyle,
                    textAlign: TextAlign.start,
                  ),
                  Image(
                    image: AssetImage(
                      AppAssets.logoRight,
                    ),
                    width: 80,
                  ),
                 
                ],
              ),

              const SizedBox(
                height: 16,
              ),

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

              SizedBox(
                width: double.infinity,
                height: 45,
                child: AppButtonWidget(
                  label: 'Join the Story!',
                  onPressed: () {},
                ),
              ),
              // const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have a library card? ',
                    style: MyFonts.titleMediumStyle18.copyWith(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Log in and reunite!',
                      style: MyFonts.subTiltleStyle12,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
