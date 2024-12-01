import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:litlore/core/theme/fonts.dart';

import 'slider_item.dart';

class TopSellingSlider extends StatelessWidget {
  final List imgList;
  const TopSellingSlider({super.key, required this.imgList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            top: 12,
          ),
          child: Row(
            children: [
              Text(
                "Top Selling",
                style: titleStyle,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios,
                ),
              ),
            ],
          ),
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
          ),
        ),
      ],
    );
  }
}
