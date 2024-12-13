import 'package:flutter/material.dart';

import '../../../../core/utils/app_methods.dart';
import 'book_basic_details.dart';
import 'book_image.dart';

class BookDetailsSection extends StatelessWidget {
  const BookDetailsSection({
    super.key,
    required this.imgUrl,
    required this.bookId,
    required this.categories,
  });

  final String imgUrl;
  final String bookId;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          SizedBox(
            width: width(context) * 0.3,
            child: Hero(
              tag: bookId,
              child: BookImage(imgUrl: imgUrl),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          BookBasicDetails(categories: categories),
        ],
      ),
    );
  }
}
