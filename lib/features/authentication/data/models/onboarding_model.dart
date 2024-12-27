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
    title: "Welcome To LitLoRe",
    body: "Ready to turn pages and escape reality? Let’s get started!",
  ),
  OnBoardingModel(
    img: AppAssets.onboarding2,
    title: "Stress Be Gone",
    body:
        "Forget yoga—grab a book! Six minutes of reading can chill you out faster than a weekend at the beach (but hey, bring the book to the beach too).",
  ),
  OnBoardingModel(
    img: AppAssets.onboarding3,
    title: "Vocabulary Wizardry",
    body:
        "Reading daily is like collecting word spells. Soon, you'll be the Dumbledore of conversations, throwing fancy words everywhere.",
  ),
  OnBoardingModel(
    img: AppAssets.onboarding4,
    title: "Midnight Adventures",
    body:
        "Ever been so hooked on a book that you told yourself, “Just one more chapter,” and then it’s suddenly 3 AM? Reading is the ultimate time traveler!",
  ),
];
