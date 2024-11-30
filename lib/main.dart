import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/features/splash/presentation/views/splash_view.dart';

void main() {
  runApp(const LitLore());
}

class LitLore extends StatelessWidget {
  const LitLore({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kScaffoldColor,
        colorScheme:
            ColorScheme.fromSeed(seedColor: kPrimaryColor),
        useMaterial3: true,
      ),
      home: const SplashView(),
    );
  }
}
