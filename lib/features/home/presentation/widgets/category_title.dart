import 'package:flutter/material.dart';

import '../../../../core/theme/fonts.dart';

class CategoryTitle extends StatelessWidget {
  final String title;
  const CategoryTitle({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        top: 12,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: MyFonts.titleMediumStyle,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward_ios,
            ),
          ),
        ],
      ),
    );
  }
}