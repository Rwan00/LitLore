import 'package:flutter/material.dart';

import '../../../../core/theme/fonts.dart';
import '../../data/models/onboarding_model.dart';

class OnboardingItemWidget extends StatelessWidget {
  final OnBoardingModel onBoardingModel;
  const OnboardingItemWidget({super.key, required this.onBoardingModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(onBoardingModel.title, style: MyFonts.logoStyle),
        const SizedBox(height: 15),
        Text(
          onBoardingModel.body,
          style: MyFonts.textStyleStyle16,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
