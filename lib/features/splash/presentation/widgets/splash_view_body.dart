import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/utils/assets.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image.asset(
            AssetsData.logo,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "LitLoRe",
                style: GoogleFonts.cinzelDecorative(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 38,
                ),
              ),
              Text(
                "Library",
                style: GoogleFonts.lustria(
                  color: kPrimaryColor,
                  fontSize: 28,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
