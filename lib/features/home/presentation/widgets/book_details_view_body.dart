import 'package:flutter/material.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';

import 'about_book_section.dart';
import 'book_action_section.dart';
import 'book_details_section.dart';

import 'release_overview_section.dart';
import 'similar_books_list.dart';

class BookDetailsViewBody extends StatelessWidget {
  final BookModel book;
  const BookDetailsViewBody({super.key, required this.book});

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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookDetailsSection(imgUrl: book.volumeInfo.imageLinks.smallThumbnail, categories: categories),
            const SizedBox(
              height: 55,
            ),
            const ReleaseOverViewSection(),
            const SizedBox(
              height: 45,
            ),
            const BookActionSection(),
            const AboutBookSection(),
            const SizedBox(
              height: 18,
            ),
            SimilarBooksList(imgUrl: book.volumeInfo.imageLinks.smallThumbnail)
          ],
        ),
      ),
    );
  }
}
