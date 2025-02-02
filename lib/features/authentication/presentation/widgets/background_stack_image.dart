import 'package:flutter/material.dart';

import '../../../../core/functions/size_functions.dart';
import '../../../../core/theme/fonts.dart';
import '../../../../core/utils/app_assets.dart';

class BackgroundStackImage extends StatelessWidget {
  const BackgroundStackImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppAssets.owlBackground,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: height(context) * 0.1,
              child: Column(
                children: [
                  Text(
                    "Unlock the Library of Dreams.",
                    style: MyFonts.headingStyle.copyWith(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    "One small step for you, one giant leap for your bookshelf.",
                    style:
                        MyFonts.subTiltleStyle14.copyWith(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        );
  }
}