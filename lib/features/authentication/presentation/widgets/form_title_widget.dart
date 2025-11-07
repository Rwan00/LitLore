import 'package:flutter/material.dart';

import '../../../../core/theme/fonts.dart';
import '../../../../core/utils/app_assets.dart';

class FormTitleWidget extends StatelessWidget {
  const FormTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Register",
          style: MyFonts.headingStyle,
          textAlign: TextAlign.start,
        ),
        Image(image: AssetImage(AppAssets.logoRight), width: 80),
      ],
    );
  }
}
