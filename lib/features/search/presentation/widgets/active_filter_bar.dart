import 'package:flutter/material.dart';
import 'package:litlore/core/theme/colors.dart';

class ActiveFilterBar extends StatelessWidget {
   final String selectedFilter;
  final String selectedOrderBy;
  final String selectedPrintType;
  const ActiveFilterBar({super.key, required this.selectedFilter, required this.selectedOrderBy, required this.selectedPrintType,});

  @override
  Widget build(BuildContext context) {
    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: MyColors.kLightBrown.withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: MyColors.kAccentBrown.withAlpha(30),
                        ),
                      ),
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