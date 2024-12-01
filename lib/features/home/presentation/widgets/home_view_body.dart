import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:litlore/features/home/presentation/widgets/slider_item.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  int? _currentIndex;
  @override
  Widget build(BuildContext context) {
    List<String> imgList = [
      'https://miblart.com/wp-content/uploads/2020/01/Daughter-of-Man-book-cover-scaled-1.jpeg',
      'https://www.creativindiecovers.com/wp-content/uploads/2012/02/9780718155209.jpg',
      "https://i.pinimg.com/564x/f7/c8/12/f7c812c9b0296cd9f119e33a06d9a256.jpg",
      "https://www.ebookconversion.com/wp-content/uploads/2015/12/0_Page_41.jpg",
    ];
    return ListView(
      children: <Widget>[
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Slider 1: Initial Page Index 0\n\n",
          textAlign: TextAlign.center,
        ),
        CarouselSlider(
          items: imgList.map((imgURL) {
            return SliderItem(imgUrl: imgURL);
          }).toList(),
          options: CarouselOptions(
              aspectRatio: 1.9,
              viewportFraction: 0.4,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              onPageChanged: (index, _) {
                setState(() {
                  _currentIndex = index;
                });
              }),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildContainer(0),
            buildContainer(1),
            buildContainer(2),
            buildContainer(3),
          ],
        ),
      ],
    );
  }

  Container buildContainer(index) {
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? Colors.deepOrange : Colors.deepPurple,
      ),
    );
  }
}
