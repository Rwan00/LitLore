import 'package:flutter/material.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/app_assets.dart';

class EmptySearchWidget extends StatelessWidget {
  final String title;
  final String discreption;
  const EmptySearchWidget({super.key, required this.title, required this.discreption});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated Book Icon
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 800),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Image(image: AssetImage(AppAssets.book), width: 150),
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: MyFonts.titleMediumStyle18.copyWith(
              fontSize: 20,
              color: MyColors.kPrimaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              discreption,
              style: MyFonts.subTiltleStyle14.copyWith(
                fontSize: 14,
                color: MyColors.kAccentBrown,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),

          // Quick Search Suggestions
        ],
      ),
    );
  }
}
