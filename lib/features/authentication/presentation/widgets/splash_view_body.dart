import 'package:flutter/material.dart';

import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/app_assets.dart';
import 'package:litlore/core/utils/app_methods.dart';
import 'package:litlore/features/authentication/presentation/views/onboarding_view.dart';



class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image.asset(
            AppAssets.splash,
            width: 250,
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedBuilder(
                  animation: slideAnimation,
                  builder: (context, _) {
                    return SlideTransition(
                      position: slideAnimation,
                      child: Text(
                        "LitLoRe",
                        style: MyFonts.logoStyle,
                      ),
                    );
                  }),
              Text(
                "Library",
                style: MyFonts.splashSubStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );
    slideAnimation = Tween<Offset>(begin: const Offset(0, 4), end: Offset.zero)
        .animate(animationController);

    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(
        seconds: 2,
      ),
      () {
        if (mounted) {
          goToPage(
              context: context, routeName: OnBoardingScreen.routeName, delete: true);
        }
      },
    );
  }
}
