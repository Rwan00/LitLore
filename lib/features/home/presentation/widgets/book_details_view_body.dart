import 'package:flutter/material.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';

import 'about_book_section.dart';
import 'book_action_section.dart';
import 'book_details_section.dart';

import 'category_title.dart';
import 'release_overview_section.dart';
import 'similar_books_list.dart';

class BookDetailsViewBody extends StatelessWidget {
  final BookModel book;
  const BookDetailsViewBody({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookDetailsSection(
            imgUrl: book.volumeInfo.imageLinks?.smallThumbnail ?? "",
            categories: book.volumeInfo.categories ?? [],
            bookId: book.id,
          ),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: CategoryTitle(title: "Similar Books"),
          ),
          SimilarBooksList(
            category: book.volumeInfo.categories?[0] ?? "",
          ),
        ],
      ),
    );
  }
}
