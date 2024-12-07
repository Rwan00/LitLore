import 'package:flutter/material.dart';

import '../../../../core/utils/app_methods.dart';
import 'book_image.dart';
import 'category_title.dart';

class SimilarBooksList extends StatelessWidget {
  const SimilarBooksList({
    super.key,
    required this.imgUrl,
  });

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CategoryTitle(title: "Similar Books"),
        SizedBox(
          height: height(context) * 0.17,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  right: 8,
                ),
                child: BookImage(imgUrl: imgUrl),
              );
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
