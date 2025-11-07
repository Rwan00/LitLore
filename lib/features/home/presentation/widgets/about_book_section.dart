import 'package:flutter/material.dart';

import 'category_title.dart';

class AboutBookSection extends StatelessWidget {
  final String description;
  const AboutBookSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          const CategoryTitle(title: "About The Book"),
          Text(description, maxLines: 5, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
