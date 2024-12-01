import 'package:flutter/material.dart';

import 'package:litlore/features/home/presentation/widgets/top_selling_slider.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> imgList = [
      'https://miblart.com/wp-content/uploads/2020/01/Daughter-of-Man-book-cover-scaled-1.jpeg',
      'https://www.creativindiecovers.com/wp-content/uploads/2012/02/9780718155209.jpg',
      "https://i.pinimg.com/564x/f7/c8/12/f7c812c9b0296cd9f119e33a06d9a256.jpg",
      "https://www.ebookconversion.com/wp-content/uploads/2015/12/0_Page_41.jpg",
    ];
    return Column(
      children: <Widget>[
        TopSellingSlider(imgList: imgList),
      ],
    );
  }
}