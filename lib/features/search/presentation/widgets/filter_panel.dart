import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/features/search/data/model/filter_options.dart';
import 'package:litlore/features/search/manager/search_cubit.dart';
import 'package:litlore/features/search/manager/search_state.dart';
import 'package:litlore/features/search/presentation/widgets/filter_section.dart';

class FilterPanel extends StatelessWidget {
  final Animation<double> filterAnimation;
  final AnimationController animationController;
  const FilterPanel({
    super.key,
    required this.filterAnimation,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return // Animated Filters Panel
    BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final cubit = context.read<SearchCubit>();
        return Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                MyColors.kCreamyWhite,
                MyColors.kCreamyWhite.withAlpha(95),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: MyColors.kPrimaryColor.withAlpha(3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: MyColors.kPrimaryColor.withAlpha(15),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: MyColors.kAccentBrown.withAlpha(1),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 3,
                    width: 77,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: MyColors.kAccentBrown,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Playful header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Filter Playground',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: MyColors.kPrimaryColor,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            'Mix & match to find your perfect read!',
                            style: TextStyle(
                              fontSize: 11,
                              color: MyColors.kAccentBrown.withAlpha(80),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          cubit.resetFilters();
                          cubit.toggleFilter(animationController);
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.refresh_rounded,
                              size: 20,
                              color: MyColors.kPrimaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Start Fresh',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: MyColors.kPrimaryColor,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Filter sections with enhanced styling
                FilterSection(
                  title: 'Book Type',
                  options: [
                    FilterOption('all', 'All Books', '📖'),
                    FilterOption('partial', 'Partial Preview', '👀'),
                    FilterOption('full', 'Full View', '🔓'),
                    FilterOption('free-ebooks', 'Free E-Books', '🎁'),
                    FilterOption('paid-ebooks', 'Paid E-Books', '💎'),
                    FilterOption('ebooks', 'All E-Books', '📱'),
                  ],
                  selectedValue: state.selectedFilter,
                  onChanged: (value) {
                    cubit.setFilter(value);
                  },
                ),

                // Fancy divider
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                MyColors.kLightBrown.withAlpha(10),
                                MyColors.kLightBrown.withAlpha(50),
                                MyColors.kLightBrown.withAlpha(10),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('✨', style: const TextStyle(fontSize: 16)),
                      ),
                      Expanded(
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                MyColors.kLightBrown.withAlpha(10),
                                MyColors.kLightBrown.withAlpha(50),
                                MyColors.kLightBrown.withAlpha(10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                FilterSection(
                  title: 'Sort Results By',
                  options: [
                    FilterOption('relevance', 'Most Relevant', '🎯'),
                    FilterOption('newest', 'Newest First', '✨'),
                  ],
                  selectedValue: state.selectedOrderBy,
                  onChanged: (value) {
                    cubit.setOrderBy(value);
                  },
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                MyColors.kLightBrown.withAlpha(10),
                                MyColors.kLightBrown.withAlpha(50),
                                MyColors.kLightBrown.withAlpha(10),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('🌟', style: const TextStyle(fontSize: 16)),
                      ),
                      Expanded(
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                MyColors.kLightBrown.withAlpha(10),
                                MyColors.kLightBrown.withAlpha(50),
                                MyColors.kLightBrown.withAlpha(10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                FilterSection(
                  title: 'Content Type',
                  options: [
                    FilterOption('all', 'Everything', '🌟'),
                    FilterOption('books', 'Books Only', '📚'),
                    FilterOption('magazines', 'Magazines Only', '📰'),
                  ],
                  selectedValue: state.selectedPrintType,
                  onChanged: (value) => cubit.setPrintType(value),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
