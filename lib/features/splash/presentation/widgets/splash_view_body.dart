import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/assets.dart';
import 'package:litlore/core/utils/consts.dart';
import 'package:litlore/features/home/presentation/views/home_view.dart';

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
            AssetsData.splash,
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
                        style: logoStyle,
                      ),
                    );
                  }),
              Text(
                "Library",
                style: splashSubStyle,
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
        Get.to(
          () => const HomeView(),
          transition: Transition.cupertino,
          duration: kTransitionDuration,
        );
      },
    );
  }
}
