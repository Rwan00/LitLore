import 'package:flutter/material.dart';


import '../../data/models/onboarding_model.dart';
import '../widgets/onboarding_item_widget.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeName = "Onboarding view";
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    var boardController = PageController();
    return Scaffold(
      body: Expanded(
        child: PageView.builder(
          controller: boardController,
          onPageChanged: (int index) {
            if (index == onBoardingList.length - 1) {
              setState(() {
                isLast = true;
              });
            } else {
              setState(() {
                isLast = false;
              });
            }
          },
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              OnboardingItemWidget(onBoardingModel: onBoardingList[index]),
          itemCount: onBoardingList.length,
        ),
      ),
    );
  }
}
