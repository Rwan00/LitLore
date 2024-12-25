import 'package:litlore/core/utils/app_assets.dart';

class OnBoardingModel {
  final String img;
  final String title;
  final String body;
  OnBoardingModel({required this.img, required this.title, required this.body});
}

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
      img: AppAssets.onboarding1,
      title: "Welcome To Swift Buy",
      body: ""),
  OnBoardingModel(
      img: AppAssets.onboarding2,
      title: "Personalized Recommendations",
      body:
          "Your preferences matter. Enjoy a personalized shopping experience with recommendations tailored just for you. The more you explore, the better we get at suggesting items you'll love."),
  OnBoardingModel(
      img: AppAssets.onboarding3,
      title: "Personalized Recommendations",
      body:
          "Your preferences matter. Enjoy a personalized shopping experience with recommendations tailored just for you. The more you explore, the better we get at suggesting items you'll love."),
];
