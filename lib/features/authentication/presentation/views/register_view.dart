/* import 'package:flutter/material.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/app_assets.dart';
import 'package:litlore/core/widgets/app_button_widget.dart';
import 'package:litlore/core/widgets/custom_input_field.dart';

class RegisterView extends StatelessWidget {
  static const routeName = "Register View";
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text(
              "Unlock the Library of Dreams.",
              style: MyFonts.headingStyle,
              textAlign: TextAlign.start,
            ),
            Text(
              "One small step for you, one giant leap for your bookshelf.",
              style: MyFonts.textStyleStyle16,
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppAssets.authBackground),
                    colorFilter: ColorFilter.linearToSrgbGamma()),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Sign Up",
                        style: MyFonts.logoStyle,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
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
                          style: MyFonts.titleMediumStyle18,
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
            Image(
              image: AssetImage(
                AppAssets.logo,
              ),
              height: 120,
            ),
          ],
        ),
      ),
    );
  }
}
 */