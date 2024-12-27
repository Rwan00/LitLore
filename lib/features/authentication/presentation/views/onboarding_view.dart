import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litlore/core/theme/colors.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/theme/fonts.dart';
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
    PageController pageController = PageController();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
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
          Column(
            children: [
              SmoothPageIndicator(
                controller: pageController,
                count: onBoardingList.length,
                effect: const SwapEffect(
                  activeDotColor: MyColors.kPrimaryColor,
                  dotWidth: 12,
                  dotHeight: 8,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              AppButton(
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
                width: 140,
                label: "Next",
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Skip",
                  style: MyFonts.logoStyle.copyWith(
                    fontSize: 18,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final void Function() onPressed;
  final double width;
  final String label;
  const AppButton({
    super.key,
    required this.onPressed,
    required this.width,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(Colors.white),
          textStyle: WidgetStateProperty.all(GoogleFonts.raleway(fontSize: 16)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          backgroundColor: WidgetStateProperty.all(
            MyColors.kPrimaryColor,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
