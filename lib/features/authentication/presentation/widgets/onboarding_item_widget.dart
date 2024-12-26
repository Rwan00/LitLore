import 'package:flutter/material.dart';

import '../../../../core/theme/fonts.dart';
import '../../data/models/onboarding_model.dart';

class OnboardingItemWidget extends StatelessWidget {
  final OnBoardingModel onBoardingModel;
  const OnboardingItemWidget({super.key, required this.onBoardingModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
        Text(
          onBoardingModel.title,
          style: MyFonts.logoStyle,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            onBoardingModel.body,
            style: MyFonts.splashSubStyle.copyWith(fontSize: 14),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
