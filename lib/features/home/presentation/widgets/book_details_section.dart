import 'package:flutter/material.dart';

import '../../../../core/utils/app_methods.dart';
import 'book_basic_details.dart';
import 'book_image.dart';

class BookDetailsSection extends StatelessWidget {
  const BookDetailsSection({
    super.key,
    required this.imgUrl,
    required this.categories,
  });

  final String imgUrl;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return Row(
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
        BookBasicDetails(categories: categories),
      ],
    );
  }
}
