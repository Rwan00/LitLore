import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

TextStyle get logoStyle {
  return GoogleFonts.cinzelDecorative(
    color: kPrimaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 26,
  );
}

TextStyle get splashSubStyle {
  return GoogleFonts.lustria(
    color: kPrimaryColor,
    fontSize: 22,
  );
}
