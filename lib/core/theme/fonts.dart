import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

abstract class MyFonts {
  static final logoStyle = GoogleFonts.cinzelDecorative(
    color: MyColors.kPrimaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 26,
  );
  static const headingStyle = TextStyle(
    color: MyColors.kPrimaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 26,
  );
  static final splashSubStyle = GoogleFonts.lustria(
    color: MyColors.kPrimaryColor,
    fontSize: 22,
  );
  static final titleMediumStyle18 = GoogleFonts.abyssinicaSil(
    color: MyColors.kPrimaryColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const textStyleStyle16 = TextStyle(
    color: Colors.grey,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static final subTiltleStyle14 = TextStyle(
    color: Colors.black.withValues(alpha: 0.4),
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static const subTiltleStyle12 = TextStyle(
    color: MyColors.kPrimaryColor,
    fontSize: 12,
  );
}
