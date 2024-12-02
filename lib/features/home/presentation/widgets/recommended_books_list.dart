import 'package:flutter/material.dart';

import 'book_item.dart';

class RecommendedBooksList extends StatelessWidget {
  final List imgList;
  const RecommendedBooksList({super.key, required this.imgList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: imgList.length,
      itemBuilder: (context, index) => BookItem(
        imgUrl: imgList[index],
      ),
    );
  }
}
