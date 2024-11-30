import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:litlore/features/splash/presentation/views/splash_view.dart';

void main() {
  runApp(const LitLore());
}

class LitLore extends StatelessWidget {
  const LitLore({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(111, 78, 55,1)),
        useMaterial3: true,
      ),
      home: const SplashView(),
    );
  }
}

