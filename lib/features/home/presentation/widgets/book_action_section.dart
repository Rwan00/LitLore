import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/fonts.dart';

class BookActionSection extends StatelessWidget {
  final String price;
  final String url;
  const BookActionSection({super.key, required this.price, required this.url});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7),
                  bottomLeft: Radius.circular(7),
                ), // Border radius
              ),
            ),
          ),
          child: Text(price, style: MyFonts.subTiltleStyle14),
        ),
        const SizedBox(width: 2),
        ElevatedButton(
          onPressed: () async {
            Uri uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          },
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(7),
                  bottomRight: Radius.circular(7),
                ), // Border radius
              ),
            ),
            backgroundColor: WidgetStatePropertyAll(
              MyColors.kPrimaryColor.withAlpha(70),
            ),
          ),
          child: Text(
            "Free Preview",
            style: MyFonts.subTiltleStyle14.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
