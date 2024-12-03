
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/fonts.dart';
import '../../../../core/utils/app_methods.dart';

class BookBasicDetails extends StatelessWidget {
  const BookBasicDetails({
    super.key,
    required this.categories,
  });

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width(context) * 0.6,
            child: Text(
              "The last four things",
              style: MyFonts.titleMediumStyle18,
              softWrap: true,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
           Text(
            "Paul Hoffman",
            style: MyFonts.subTiltleStyle14,
          ),
          const SizedBox(
            height: 6,
          ),
          const Text(
            "Released on: 2015-05-22",
            style: MyFonts.subTiltleStyle12,
          ),
          const SizedBox(
            height: 6,
          ),
          Wrap(
            direction: Axis.horizontal,
            children: List.generate(
              categories.length,
              (index) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: MyColors.kPrimaryColor.withOpacity(0.3),
                    ),
                    child: Text(
                      categories[index],
                      style: MyFonts.subTiltleStyle12,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
