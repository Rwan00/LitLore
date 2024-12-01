import 'package:flutter/material.dart';

class SliderItem extends StatelessWidget {
  final String imgUrl;
  const SliderItem({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: AspectRatio(
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
    );
  }
}
