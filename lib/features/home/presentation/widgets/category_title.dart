import 'package:flutter/material.dart';

import '../../../../core/theme/fonts.dart';

class CategoryTitle extends StatelessWidget {
  final String title;
  const CategoryTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: MyFonts.titleMediumStyle18),
        const Spacer(),
        IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
      ],
    );
  }
}
