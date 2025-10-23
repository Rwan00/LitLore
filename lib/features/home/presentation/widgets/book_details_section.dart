import 'package:flutter/material.dart';


import '../../../../core/functions/size_functions.dart';
import '../../data/models/book_model/book_model.dart';
import 'book_basic_details.dart';
import 'book_image.dart';

class BookDetailsSection extends StatelessWidget {
  const BookDetailsSection({
    super.key, required this.book,
  });

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          SizedBox(
            width: width(context) * 0.3,
            child: Hero(
              tag: book.id,
              child: BookImage(imgUrl: book.volumeInfo?.imageLinks?.smallThumbnail??"",),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          BookBasicDetails(book: book),
        ],
      ),
    );
  }
}
