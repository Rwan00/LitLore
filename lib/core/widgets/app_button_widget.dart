import 'package:flutter/material.dart';
import 'package:litlore/core/theme/fonts.dart';

import '../theme/colors.dart';

class AppButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final double? width;
  final String label;
  const AppButtonWidget({
    super.key,
    required this.onPressed,
    this.width,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(Colors.white),
          textStyle: WidgetStateProperty.all(MyFonts.titleMediumStyle18),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          ),
          backgroundColor: WidgetStateProperty.all(MyColors.kPrimaryColor),
        ),
        child: Text(label),
      ),
    );
  }
}
