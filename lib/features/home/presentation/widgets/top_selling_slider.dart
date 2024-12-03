import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'category_title.dart';
import 'book_image.dart';

class TopSellingSlider extends StatelessWidget {
  final List imgList;
  const TopSellingSlider({super.key, required this.imgList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 12,
          ),
          child: CategoryTitle(
            title: "Top Selling",
          ),
        ),
        CarouselSlider(
          items: imgList.map((imgURL) {
            return BookImage(imgUrl: imgURL);
          }).toList(),
          options: CarouselOptions(
            aspectRatio: 1.67,
            viewportFraction: 0.4,
            initialPage: 0,
            enlargeCenterPage: true,
            pauseAutoPlayOnManualNavigate: true,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
            disableCenter: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
          ),
        ),
      ],
    );
  }
}
