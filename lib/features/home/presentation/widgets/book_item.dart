import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/theme/fonts.dart';

import 'book_rating.dart';

class BookItem extends StatelessWidget {
  final String imgUrl;
  const BookItem({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        padding: const EdgeInsets.all(4),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: MyColors.kPrimaryColor.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 2.7 / 4,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      imgUrl,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
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
                  const Text(
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
                      "19.99 L.E",
                      style: MyFonts.textStyleStyle16,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
