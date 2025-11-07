import 'package:flutter/material.dart';

import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/utils/app_assets.dart';

import 'package:litlore/features/search/presentation/widgets/filter_panel.dart';

class ActiveFilterBar extends StatelessWidget {
  final String selectedFilter;
  final String selectedOrderBy;
  final String selectedPrintType;
  final AnimationController animationController;
  final Animation<double> filterAnimation;

  const ActiveFilterBar({
    super.key,
    required this.selectedFilter,
    required this.selectedOrderBy,
    required this.selectedPrintType,
    required this.animationController,
    required this.filterAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: MyColors.kLightBrown.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: MyColors.kAccentBrown.withAlpha(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  'Active: ',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: MyColors.kPrimaryColor,
                  ),
                ),
                Expanded(
                  child: Text(
                    [
                      if (selectedFilter != 'all')
                        _getFilterLabel(selectedFilter),
                      if (selectedOrderBy != 'relevance')
                        _getOrderByLabel(selectedOrderBy),
                      if (selectedPrintType != 'all')
                        _getPrintTypeLabel(selectedPrintType),
                    ].join(' • '),
                    style: TextStyle(
                      fontSize: 12,
                      color: MyColors.kAccentBrown,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          RotationTransition(
            turns: Tween(begin: 0.0, end: 0.5).animate(
              CurvedAnimation(
                parent: animationController,
                curve: Curves.easeInOut,
              ),
            ),
            child: IconButton(
              onPressed: () {
                showBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (context) => FilterPanel(
                    filterAnimation: filterAnimation,
                    animationController: animationController,
                  ),
                );
              },
              icon: Image(image: AssetImage(AppAssets.arrow)),
            ),
          ),
        ],
      ),
    );
  }
}

String _getFilterLabel(String filter) {
  return {
        'partial': 'Partial',
        'full': 'Full View',
        'free-ebooks': 'Free',
        'paid-ebooks': 'Paid',
        'ebooks': 'E-Books',
      }[filter] ??
      filter;
}

String _getOrderByLabel(String order) {
  return order == 'newest' ? 'Newest' : 'Relevant';
}

String _getPrintTypeLabel(String type) {
  return {'books': 'Books', 'magazines': 'Magazines'}[type] ?? type;
}
