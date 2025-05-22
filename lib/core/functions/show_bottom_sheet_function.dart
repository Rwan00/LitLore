import 'package:flutter/material.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/app_assets.dart';
import 'package:litlore/core/widgets/app_button_widget.dart';

void showBottomSheetFunction(BuildContext context, String message) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppAssets.owlError,
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              textAlign: TextAlign.center,
              style: MyFonts.textStyleStyle16.copyWith(
                color: MyColors.kPrimaryColor,
              ),
            ),
            const SizedBox(height: 15),
            AppButtonWidget(
              onPressed: () {
                Navigator.pop(context);
              },
              label: "Sorry",
            ),
          ],
        ),
      );
    },
  );
}
