import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';
import 'package:litlore/features/home/presentation/views/category_books_view.dart';

import '../../../../core/functions/size_functions.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/fonts.dart';


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
             book.volumeInfo?.title??"Nameless, but still legendary.",
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
  book.volumeInfo?.authors?.join(', ') ?? "Anonymous genius",
  style: MyFonts.subTiltleStyle14,
),

          const SizedBox(
            height: 6,
          ),
           Text(
  "Released on: ${book.volumeInfo?.publishedDate ?? "a day lost to history"}",
  style: MyFonts.subTiltleStyle12,
),

          const SizedBox(
            height: 6,
          ),
          Wrap(
            direction: Axis.horizontal,
            children: List.generate(
              book.volumeInfo?.categories?.length??0,
              (index) {
                return GestureDetector(
                  onTap: (){
                    context.push(CategoryBooksView.routeName, extra: {"title": book.volumeInfo?.categories?[index]});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: MyColors.kPrimaryColor.withAlpha(30),
                      ),
                      child: Text(
                        book.volumeInfo?.categories?[index]??"undefined chaos",
                        style: MyFonts.subTiltleStyle12,
                      ),
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
