import 'package:flutter/material.dart';

import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/assets.dart';

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
            AssetsData.logo,
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
                        style: splashStyle,
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
}
