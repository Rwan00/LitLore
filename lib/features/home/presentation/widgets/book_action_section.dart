import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/fonts.dart';

class BookActionSection extends StatelessWidget {
  const BookActionSection({
    super.key,
  });

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
          child: Text(
            "Buy For 11.11 L.E",
            style: MyFonts.subTiltleStyle14,
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        ElevatedButton(
          onPressed: () {},
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
              MyColors.kPrimaryColor.withOpacity(0.7),
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
