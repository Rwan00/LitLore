import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/routes/app_routes.dart';

void main() {
  runApp(const LitLore());
}

class LitLore extends StatelessWidget {
  const LitLore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      theme: ThemeData(
        scaffoldBackgroundColor: MyColors.kScaffoldColor,
        appBarTheme: const AppBarTheme(color: MyColors.kScaffoldColor),
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.kPrimaryColor),
        useMaterial3: true,
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
    );
  }
}
