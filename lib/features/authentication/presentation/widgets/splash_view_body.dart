import 'package:flutter/material.dart';

import 'package:litlore/core/utils/app_assets.dart';

import 'package:litlore/features/authentication/presentation/views/onboarding_view.dart';

import '../../../../core/functions/navigations_functions.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();

    navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppAssets.splash,
        width: 250,
        fit: BoxFit.cover,
      ),
    );
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () {
        if (mounted) {
          goToPage(
              context: context,
              routeName: OnBoardingScreen.routeName,
              delete: true,);
        }
      },
    );
  }
}
