import 'package:flutter/material.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/app_assets.dart';

class CustomErrorWidget extends StatelessWidget {
  final String error;
  final void Function() retryFunction;
  const CustomErrorWidget({super.key, required this.error,required this.retryFunction,});

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
        ),
        TextButton.icon(
          onPressed: retryFunction,
          label: Text(
            "Try again",
            style: MyFonts.subTiltleStyle14,
          ),
          icon: const Icon(
            Icons.restart_alt_sharp,
          ),
        ),
      ],
    );
  }
}
