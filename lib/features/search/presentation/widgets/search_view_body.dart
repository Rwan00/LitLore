import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/app_assets.dart';
import 'package:litlore/core/widgets/flapping_owl_loading.dart';
import 'package:litlore/features/search/manager/search_cubit.dart';
import 'package:litlore/features/search/manager/search_state.dart';
import 'package:litlore/features/search/presentation/widgets/active_filter_bar.dart';
import 'package:litlore/features/search/presentation/widgets/custom_search_bar.dart';

import 'filter_panel.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  late AnimationController _filterAnimationController;
  late Animation<double> _filterAnimation;

  @override
  void initState() {
    super.initState();
    _filterAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _filterAnimation = CurvedAnimation(
      parent: _filterAnimationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _filterAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // Funny Header
                  Row(
                    children: [
                      Image(image: AssetImage(AppAssets.search), width: 24),
                      Text(
                        ' Book Detective Mode',
                        style: MyFonts.titleMediumStyle18.copyWith(
                          fontSize: 24,
                          color: MyColors.kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'What literary treasure are we hunting today?',
                    style: MyFonts.subTiltleStyle14.copyWith(
                      fontSize: 14,
                      color: MyColors.kAccentBrown,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Search Bar
                  CustomSearchBar(
                    searchController: _searchController,
                    animationController: _filterAnimationController,
                  ),
                  const SizedBox(height: 16),
                  FilterPanel(filterAnimation: _filterAnimation),
                  const SizedBox(height: 16),

                  // Active Filters Summary (when collapsed)
                  if (!state.showFilter &&
                      (state.selectedFilter != 'all' ||
                          state.selectedOrderBy != 'relevance' ||
                          state.selectedPrintType != 'all'))
                    ActiveFilterBar(
                      selectedFilter: state.selectedFilter,
                      selectedOrderBy: state.selectedOrderBy,
                      selectedPrintType: state.selectedPrintType,
                    ),

                  if (!state.showFilter &&
                      (state.selectedFilter != 'all' ||
                          state.selectedOrderBy != 'relevance' ||
                          state.selectedPrintType != 'all'))
                    const SizedBox(height: 16),
                  //_isSearching ? _buildSearchResults() : _buildEmptyState(),

                  // Content Area
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated Book Icon
          TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 800),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: value,
                child: Image(image: AssetImage(AppAssets.book), width: 150),
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            'The shelves are waiting...',
            style: MyFonts.titleMediumStyle18.copyWith(
              fontSize: 20,
              color: MyColors.kPrimaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Start typing to summon books from the magical library!',
              style: MyFonts.subTiltleStyle14.copyWith(
                fontSize: 14,
                color: MyColors.kAccentBrown,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),

          // Quick Search Suggestions
         
        ],
      ),
    );
  }

 

  Widget _buildSearchResults(
      String selectedFilter,
   String selectedOrderBy,
   String selectedPrintType,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          children: [
            Text(
              'Searching for: ',
              style: MyFonts.subTiltleStyle14.copyWith(
                fontSize: 14,
                color: MyColors.kAccentBrown,
              ),
            ),
            Text(
              '"${_searchController.text}"',
              style: MyFonts.titleMediumStyle18.copyWith(
                fontSize: 16,
                color: MyColors.kPrimaryColor,
              ),
            ),
          ],
        ),
        if (selectedFilter != 'all' ||
            selectedOrderBy != 'relevance' ||
            selectedPrintType != 'all')
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'with special filters 🎯',
              style: TextStyle(
                fontSize: 12,
                color: MyColors.kAccentBrown,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        const SizedBox(height: 16),
        Expanded(
          child: Center(
            child: FlappingOwlLoading(
              loadingText:
                  'Our wisest owls are searching...\n Flipping through ${(_searchController.text.length * 1000)} pages!',
            ),
          ),
        ),
      ],
    );
  }
}
