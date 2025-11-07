import 'package:flutter/material.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/utils/app_assets.dart';

import '../../../../core/theme/fonts.dart';

class GoogleSigningBtn extends StatelessWidget {
  final void Function() onPressed;
  const GoogleSigningBtn({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            MyFonts.titleMediumStyle18.copyWith(color: MyColors.kPrimaryColor),
          ),

          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          ),
          backgroundColor: WidgetStateProperty.all(Colors.white),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Continue With Google"),
            SizedBox(width: 5),
            Image.asset(AppAssets.google, height: 20),
          ],
        ),
      ),
    );
  }
}
