import 'package:flutter/material.dart';
import 'package:litlore/core/theme/colors.dart';

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
      body: Column(
        children: [
          Expanded(
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
          const SizedBox(
            height: 85,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                /* SmoothPageIndicator(
                controller: boardController,
                count: onBoardingList.length,
                effect: JumpingDotEffect(
                    verticalOffset: 20,
                    jumpScale: 1.6,
                    activeDotColor: MyColors.kPrimaryColor,
                    dotWidth: 24,
                    dotHeight: 8),
              ), */
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    /*  isLast
                      ? CacheHelper.saveData(key: "onBoarding", value: true)
                          .then((value) {
                          if (value == true) {
                            animatedNavigateAndDelete(
                                context: context,
                                widget: const SignScreen(),
                                direction: PageTransitionType.leftToRight,
                                curve: Curves.easeInOutCirc);
                          }
                        })
                      : boardController.nextPage(
                          duration: const Duration(milliseconds: 900),
                          curve: Curves.easeInOutBack); */
                  },
                  backgroundColor: MyColors.kPrimaryColor.withRed(1),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
