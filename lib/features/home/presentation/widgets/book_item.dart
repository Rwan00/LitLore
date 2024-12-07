import 'package:flutter/material.dart';

import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/app_methods.dart';
import 'package:litlore/features/home/presentation/views/book_details_view.dart';
import 'package:litlore/features/home/presentation/widgets/book_image.dart';

import 'book_rating.dart';

class BookItem extends StatelessWidget {
  final String imgUrl;
  const BookItem({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goToPage(
        context: context,
        routeName: BookDetailsView.routeName,
        delete: false,
        arguments: imgUrl,
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
              Hero(
                tag: imgUrl,
                child: BookImage(imgUrl: imgUrl),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width(context) * 0.5,
                      child: const Text(
                        "The last four things",
                        style: MyFonts.textStyleStyle16,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Paul Hoffman",
                      style: MyFonts.subTiltleStyle14,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const BookRating(),
                    const Spacer(),
                    const Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Text(
                        "11.11 L.E",
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
