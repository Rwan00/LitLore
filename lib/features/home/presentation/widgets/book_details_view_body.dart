import 'package:flutter/material.dart';



import 'book_details_section.dart';

import 'release_overview_section.dart';

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
          BookDetailsSection(imgUrl: imgUrl, categories: categories),
          const SizedBox(
            height: 55,
          ),
          const ReleaseOverViewSection()
        ],
      ),
    );
  }
}


