import 'package:flutter/material.dart';

import 'package:litlore/core/utils/app_methods.dart';
import 'package:litlore/features/home/presentation/widgets/book_image.dart';


import 'book_basic_details.dart';

class BookDetailsViewBody extends StatelessWidget {
  final String imgUrl;
  const BookDetailsViewBody({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      "Programming",
      "Science Fiction",
      "Comedy",
      "Romance",
      "Drama",
      "Historical",
      "Action"
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Hero(
                tag: imgUrl,
                child: SizedBox(
                  width: width(context) * 0.3,
                  child: BookImage(imgUrl: imgUrl),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              BookBasicDetails(categories: categories)
            ],
          ),
        ],
      ),
    );
  }
}

