import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/app_assets.dart';
import 'package:litlore/features/search/manager/search_cubit.dart';
import 'package:litlore/features/search/manager/search_state.dart';
import 'package:litlore/features/search/presentation/widgets/active_filter_bar.dart';
import 'package:litlore/features/search/presentation/widgets/custom_search_bar.dart';
import 'package:litlore/features/search/presentation/widgets/empty_search_widget.dart';
import 'package:litlore/features/search/presentation/widgets/searching_results.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
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
    _onScroll();
  }

  _onScroll() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!context.read<SearchCubit>().state.hadReachedMax) {
          context.read<SearchCubit>().loadMore(
            context.read<SearchCubit>().state.searchKey!,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _filterAnimationController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
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
              controller: _scrollController,
              // ✅ مهم جدًا
              physics: const ClampingScrollPhysics(),
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
                    filterAnimation: _filterAnimation,
                  ),
                  const SizedBox(height: 8),
                  // Active Filters Summary (when collapsed)
                  if ((state.selectedFilter != 'all' ||
                      state.selectedOrderBy != 'relevance' ||
                      state.selectedPrintType != 'all'))
                    ActiveFilterBar(
                      selectedFilter: state.selectedFilter,
                      selectedOrderBy: state.selectedOrderBy,
                      selectedPrintType: state.selectedPrintType,
                      animationController: _filterAnimationController,
                      filterAnimation: _filterAnimation,
                    ),

                  const SizedBox(height: 8),

                  if (!state.showFilter &&
                      (state.selectedFilter != 'all' ||
                          state.selectedOrderBy != 'relevance' ||
                          state.selectedPrintType != 'all'))
                    const SizedBox(height: 16),
                  state.isSearching ?? false
                      ? SearchingResults(searchController: _searchController)
                      : EmptySearchWidget(
                          title: 'The shelves are waiting...',
                          discreption:
                              'Start typing to summon books from the magical library!',
                        ),

                  // Content Area
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
