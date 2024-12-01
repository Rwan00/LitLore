import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

abstract class MyFonts {
  static final logoStyle = GoogleFonts.cinzelDecorative(
    color: MyColors.kPrimaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 26,
  );
  static final splashSubStyle  = GoogleFonts.lustria(
    color: MyColors.kPrimaryColor,
    fontSize: 22,
  );
  static final titleMediumStyle = GoogleFonts.margarine(
    color: MyColors.kPrimaryColor,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
}



