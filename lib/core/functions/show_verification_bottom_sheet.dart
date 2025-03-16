import 'package:flutter/material.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/app_assets.dart';
import 'package:litlore/core/widgets/app_button_widget.dart';

void showVerificationBottomSheet({required BuildContext context,required void Function() onPressed}) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Verify Your Email'),
            Image.asset(
              AppAssets.owlError,
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 10),
            Text(
              "We’ve sent an email! Now go prove you're not a robot... or a plot twist",
              textAlign: TextAlign.center,
              style: MyFonts.textStyleStyle16.copyWith(
                color: MyColors.kPrimaryColor,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: AppButtonWidget(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: "I'm a Robot",
                  ),
                ),
                Expanded(
                  child: AppButtonWidget(
                    onPressed: onPressed,
                    label: "Ok, Turn the page",
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
