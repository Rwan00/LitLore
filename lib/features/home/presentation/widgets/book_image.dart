import 'package:flutter/material.dart';

class BookImage extends StatelessWidget {
  final String imgUrl;
  const BookImage({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.6 / 4,
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
    );
  }
}
