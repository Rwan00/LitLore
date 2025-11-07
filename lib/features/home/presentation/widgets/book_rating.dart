import 'package:flutter/material.dart';

import '../../../../core/theme/fonts.dart';

class BookRating extends StatelessWidget {
  final num rating;
  final num count;
  const BookRating({super.key, required this.rating, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.orange, size: 12),
        const SizedBox(width: 4),
        Text(rating.toString(), style: MyFonts.subTiltleStyle12),
        const SizedBox(width: 4),
        Text(
          "($count)",
          style: MyFonts.subTiltleStyle12.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
