import 'package:flutter/material.dart';

import '../../../../core/theme/fonts.dart';
import '../../data/models/onboarding_model.dart';

class OnboardingItemWidget extends StatelessWidget {
  final OnBoardingModel onBoardingModel;
  const OnboardingItemWidget({super.key, required this.onBoardingModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
          ),
          Text(
            onBoardingModel.body,
            style: MyFonts.subTiltleStyle14.copyWith(fontSize: 16),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
