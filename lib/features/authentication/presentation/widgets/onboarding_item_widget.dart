import 'package:flutter/material.dart';
import 'package:litlore/core/theme/colors.dart';

import '../../../../core/theme/fonts.dart';
import '../../data/models/onboarding_model.dart';

class OnboardingItemWidget extends StatelessWidget {
  final OnBoardingModel onBoardingModel;
  const OnboardingItemWidget({super.key, required this.onBoardingModel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).scaffoldBackgroundColor,
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0, 0.5],
            ),
          ),
          // height: 300,
          //width: double.infinity,
          child: Image.asset(
            onBoardingModel.img,
            height: 500,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        TextButton(
          onPressed: () {
            /* CacheHelper.saveData(key: "onBoarding", value: true)
                    .then((value) {
                  if (value == true) {
                    animatedNavigateAndDelete(
                        context: context,
                        widget: const SignScreen(),
                        direction: PageTransitionType.leftToRight,
                        curve: Curves.easeInOutCirc);
                  }
                }); */
          },
          child: Text(
            "SKIP",
            style: MyFonts.logoStyle,
          ),
        ),
      ],
    );
  }
}
