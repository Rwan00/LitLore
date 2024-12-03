import 'package:flutter/material.dart';

import '../../../../core/theme/fonts.dart';
import 'book_rating.dart';
import 'custom_vertical_divider.dart';

class ReleaseOverViewSection extends StatelessWidget {
  const ReleaseOverViewSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Column(
          children: [
            BookRating(),
            Text(
              "Review",
              style: MyFonts.subTiltleStyle12,
            ),
          ],
        ),
        const CustomVerticalDivider(),
        Column(
          children: [
            Text(
              "English",
              style: MyFonts.subTiltleStyle12.copyWith(
                color: Colors.grey,
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
              "190",
              style: MyFonts.subTiltleStyle12.copyWith(
                color: Colors.grey,
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
              "US",
              style: MyFonts.subTiltleStyle12.copyWith(
                color: Colors.grey,
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
            Text(
              "Arcadia",
              style: MyFonts.subTiltleStyle12.copyWith(
                color: Colors.grey,
              ),
            ),
            const Text(
              "Publisher",
              style: MyFonts.subTiltleStyle12,
            ),
          ],
        ),
      ],
    );
  }
}