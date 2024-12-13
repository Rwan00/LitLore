import 'package:flutter/material.dart';

import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/app_methods.dart';
import 'package:litlore/features/home/data/models/book_model/book_model.dart';

import 'package:litlore/features/home/presentation/views/book_details_view.dart';
import 'package:litlore/features/home/presentation/widgets/book_image.dart';

import 'book_rating.dart';

class BookItem extends StatelessWidget {
  final BookModel book;
  const BookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goToPage(
        context: context,
        routeName: BookDetailsView.routeName,
        delete: false,
        arguments: book,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 2),
        child: Container(
          padding: const EdgeInsets.all(4),
          width: double.infinity,
          height: height(context) * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              color: MyColors.kPrimaryColor.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              BookImage(imgUrl: book.volumeInfo.imageLinks?.smallThumbnail??""),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width(context) * 0.54,
                      child: Text(
                        book.volumeInfo.title,
                        style: MyFonts.textStyleStyle16,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      book.volumeInfo.authors?.take(2).join(', ') ?? '',
                      style: MyFonts.subTiltleStyle14,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                     BookRating(rating: book.volumeInfo.averageRating!,count:book.volumeInfo.ratingsCount!),
                    const Spacer(),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Text(
                        book.saleInfo?.saleability == "FOR_SALE"
                            ? "${book.saleInfo?.listPrice?.amount} ${book.saleInfo?.listPrice?.currencyCode}"
                            : "Not for sale",
                        style: MyFonts.textStyleStyle16,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
