import 'package:flutter/material.dart';
import 'package:litlore/core/utils/app_methods.dart';
import 'package:litlore/features/home/presentation/widgets/book_image.dart';

class BookDetailsViewBody extends StatelessWidget {
  final String imgUrl;
  const BookDetailsViewBody({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: imgUrl,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width(context) * 0.3),
            child: BookImage(imgUrl: imgUrl),
          ),
        ),
      ],
    );
  }
}
