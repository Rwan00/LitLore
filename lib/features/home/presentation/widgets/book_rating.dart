import 'package:flutter/material.dart';


import '../../../../core/theme/fonts.dart';

class BookRating extends StatelessWidget {
  const BookRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.orange,
          size: 12,
        ),
        const SizedBox(
          width: 4,
        ),
        const Text(
          "4.8",
          style: MyFonts.subTiltleStyle12,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          "(2658)",
          style: MyFonts.subTiltleStyle12.copyWith(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
