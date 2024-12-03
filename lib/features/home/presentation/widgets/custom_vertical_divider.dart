import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 30,
        width: 2,
        color: MyColors.kPrimaryColor.withOpacity(0.6),
      ),
    );
  }
}