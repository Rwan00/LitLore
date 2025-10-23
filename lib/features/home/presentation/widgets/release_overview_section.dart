import 'package:flutter/material.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';

import '../../../../core/theme/fonts.dart';

import 'book_rating.dart';
import 'custom_vertical_divider.dart';

class ReleaseOverViewSection extends StatelessWidget {
  const ReleaseOverViewSection({
    super.key,
    required this.book,
  });
  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              BookRating(
                rating: book.volumeInfo?.averageRating??0,
                count: book.volumeInfo?.ratingsCount??0,
              ),
              const Text(
                "Review",
                style: MyFonts.subTiltleStyle12,
              ),
            ],
          ),
          const CustomVerticalDivider(),
          Column(
            children: [
              Text(
                book.volumeInfo?.language ?? "emotions only",
                style: MyFonts.subTiltleStyle12.copyWith(
                  color: Colors.black,
                ),
              ),
              const Text(
                "Language",
                style: MyFonts.subTiltleStyle12,
              ),
            ],
          ),
          const CustomVerticalDivider(),
          Column(
            children: [
              Text(
                "${book.volumeInfo?.pageCount}",
                style: MyFonts.subTiltleStyle12.copyWith(
                  color: Colors.black,
                ),
              ),
              const Text(
                "Pages",
                style: MyFonts.subTiltleStyle12,
              ),
            ],
          ),
          const CustomVerticalDivider(),
          Column(
            children: [
              Text(
                "${book.saleInfo?.country}",
                style: MyFonts.subTiltleStyle12.copyWith(
                  color: Colors.black,
                ),
              ),
              const Text(
                "Country",
                style: MyFonts.subTiltleStyle12,
              ),
            ],
          ),
          const CustomVerticalDivider(),
          Column(
            children: [
              SizedBox(
                width: 65,
                child: Text(
                  book.volumeInfo?.publisher ?? "the universe itself",
                  style: MyFonts.subTiltleStyle12.copyWith(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Text(
                "Publisher",
                style: MyFonts.subTiltleStyle12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
