import 'package:flutter/material.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/fonts.dart';
import '../../../../core/utils/app_methods.dart';

class BookBasicDetails extends StatelessWidget {
  const BookBasicDetails({
    super.key,
    required this.book,
  });

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width(context) * 0.6,
            child: Text(
             book.volumeInfo.title,
              style: MyFonts.titleMediumStyle18,
              softWrap: true,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            book.volumeInfo.authors?.join(', ') ?? '',
            style: MyFonts.subTiltleStyle14,
          ),
          const SizedBox(
            height: 6,
          ),
           Text(
            "Released on: ${book.volumeInfo.publishedDate}",
            style: MyFonts.subTiltleStyle12,
          ),
          const SizedBox(
            height: 6,
          ),
          Wrap(
            direction: Axis.horizontal,
            children: List.generate(
              book.volumeInfo.categories?.length??0,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: MyColors.kPrimaryColor.withOpacity(0.3),
                    ),
                    child: Text(
                      book.volumeInfo.categories?[index]??"",
                      style: MyFonts.subTiltleStyle12,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
