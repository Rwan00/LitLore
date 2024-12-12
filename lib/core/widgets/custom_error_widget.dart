import 'package:flutter/material.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/app_assets.dart';

class CustomErrorWidget extends StatelessWidget {
  final String error;
  const CustomErrorWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(
          image: AssetImage(
            AssetsData.sad,
          ),
          width: 64,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34.0),
          child: Text(
            error,
            style: MyFonts.textStyleStyle16,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
