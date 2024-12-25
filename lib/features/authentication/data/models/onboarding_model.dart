class OnBoardingModel{
  final String img;
  final String title;
  final String body;
  OnBoardingModel({required this.img,required this.title,required this.body});
}

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(img: "assets/images/onboarding3.jpg", title: "Welcome To Swift Buy", body: ""),
  OnBoardingModel(img: "assets/images/onboarding2.jpg", title: "Seamless Shopping Experience ", body: "Effortlessly browse through a wide range of products, add them to your cart, and check out in a few simple steps. We've designed our app to make your shopping journey smooth and enjoyable."),
  OnBoardingModel(img: "assets/images/onboarding1.jpg", title: "Personalized Recommendations", body: "Your preferences matter. Enjoy a personalized shopping experience with recommendations tailored just for you. The more you explore, the better we get at suggesting items you'll love."),
  

];