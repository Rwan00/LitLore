import 'package:flutter/material.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/app_assets.dart';
import 'package:litlore/core/widgets/flapping_owl_loading.dart';
import 'package:litlore/features/search/presentation/widgets/custom_search_bar.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  bool _showFilters = false;

  // Google Books API filter options
  String _selectedFilter = 'all';
  String _selectedOrderBy = 'relevance';
  String _selectedPrintType = 'all';

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
              // Animated Filters Panel
              SizeTransition(
                sizeFactor: _filterAnimation,
                child: Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        MyColors.kCreamyWhite,
                        MyColors.kCreamyWhite.withOpacity(0.95),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: MyColors.kPrimaryColor.withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: MyColors.kPrimaryColor.withOpacity(0.15),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 6),
                      ),
                      BoxShadow(
                        color: MyColors.kAccentBrown.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Playful header
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  MyColors.kPrimaryColor.withOpacity(0.2),
                                  MyColors.kAccentBrown.withOpacity(0.2),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '🎨',
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                          const SizedBox(width: 12),
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
                                    color: MyColors.kAccentBrown.withOpacity(
                                      0.8,
                                    ),
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Filter sections with enhanced styling
                      _buildFilterSection(
                        '📚 Book Type',
                        [
                          _FilterOption('all', 'All Books', '📖'),
                          _FilterOption('partial', 'Partial Preview', '👀'),
                          _FilterOption('full', 'Full View', '🔓'),
                          _FilterOption('free-ebooks', 'Free E-Books', '🎁'),
                          _FilterOption('paid-ebooks', 'Paid E-Books', '💎'),
                          _FilterOption('ebooks', 'All E-Books', '📱'),
                        ],
                        _selectedFilter,
                        (value) => setState(() => _selectedFilter = value),
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
                                      MyColors.kLightBrown.withOpacity(0.1),
                                      MyColors.kLightBrown.withOpacity(0.5),
                                      MyColors.kLightBrown.withOpacity(0.1),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Text(
                                '✨',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      MyColors.kLightBrown.withOpacity(0.1),
                                      MyColors.kLightBrown.withOpacity(0.5),
                                      MyColors.kLightBrown.withOpacity(0.1),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      _buildFilterSection(
                        '🎲 Sort Results By',
                        [
                          _FilterOption('relevance', 'Most Relevant', '🎯'),
                          _FilterOption('newest', 'Newest First', '✨'),
                        ],
                        _selectedOrderBy,
                        (value) => setState(() => _selectedOrderBy = value),
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
                                      MyColors.kLightBrown.withOpacity(0.1),
                                      MyColors.kLightBrown.withOpacity(0.5),
                                      MyColors.kLightBrown.withOpacity(0.1),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Text(
                                '🌟',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      MyColors.kLightBrown.withOpacity(0.1),
                                      MyColors.kLightBrown.withOpacity(0.5),
                                      MyColors.kLightBrown.withOpacity(0.1),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      _buildFilterSection(
                        '📰 Content Type',
                        [
                          _FilterOption('all', 'Everything', '🌟'),
                          _FilterOption('books', 'Books Only', '📚'),
                          _FilterOption('magazines', 'Magazines Only', '📰'),
                        ],
                        _selectedPrintType,
                        (value) => setState(() => _selectedPrintType = value),
                      ),

                      const SizedBox(height: 20),

                      // Enhanced Reset Button
                      Center(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedFilter = 'all';
                              _selectedOrderBy = 'relevance';
                              _selectedPrintType = 'all';
                            });
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  MyColors.kLightBrown.withOpacity(0.3),
                                  MyColors.kLightBrown.withOpacity(0.2),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: MyColors.kAccentBrown.withOpacity(0.4),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: MyColors.kPrimaryColor.withOpacity(
                                    0.1,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
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
                                const SizedBox(width: 4),
                                Text(
                                  '🔄',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Active Filters Summary (when collapsed)
              if (!_showFilters &&
                  (_selectedFilter != 'all' ||
                      _selectedOrderBy != 'relevance' ||
                      _selectedPrintType != 'all'))
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: MyColors.kLightBrown.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: MyColors.kAccentBrown.withOpacity(0.3),
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
                            if (_selectedFilter != 'all')
                              _getFilterLabel(_selectedFilter),
                            if (_selectedOrderBy != 'relevance')
                              _getOrderByLabel(_selectedOrderBy),
                            if (_selectedPrintType != 'all')
                              _getPrintTypeLabel(_selectedPrintType),
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

              if (!_showFilters &&
                  (_selectedFilter != 'all' ||
                      _selectedOrderBy != 'relevance' ||
                      _selectedPrintType != 'all'))
                const SizedBox(height: 16),
              //_isSearching ? _buildSearchResults() : _buildEmptyState(),

              // Content Area
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(
    String title,
    List<_FilterOption> options,
    String selectedValue,
    Function(String) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Fancy animated title with icon
        Row(
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 500),
              builder: (context, double value, child) {
                return Transform.rotate(
                  angle: value * 0.1,
                  child: Text(
                    title.split(' ')[0],
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title.substring(title.indexOf(' ') + 1),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: MyColors.kPrimaryColor,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Animated options grid
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: options.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            final isSelected = selectedValue == option.value;

            return TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 300 + (index * 50)),
              curve: Curves.elasticOut,
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: InkWell(
                    onTap: () {
                      onChanged(option.value);
                      // Optional: Add haptic feedback
                      // HapticFeedback.lightImpact();
                    },
                    borderRadius: BorderRadius.circular(25),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? LinearGradient(
                                colors: [
                                  MyColors.kPrimaryColor,
                                  MyColors.kAccentBrown,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : LinearGradient(
                                colors: [
                                  MyColors.kCreamyWhite,
                                  MyColors.kCreamyWhite.withOpacity(0.8),
                                ],
                              ),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: isSelected
                              ? MyColors.kPrimaryColor.withOpacity(0.8)
                              : MyColors.kLightBrown.withOpacity(0.4),
                          width: isSelected ? 2.5 : 1.5,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: MyColors.kPrimaryColor.withOpacity(
                                    0.4,
                                  ),
                                  blurRadius: 12,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 4),
                                ),
                                BoxShadow(
                                  color: MyColors.kAccentBrown.withOpacity(0.2),
                                  blurRadius: 8,
                                  spreadRadius: -2,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: MyColors.kLightBrown.withOpacity(0.15),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Animated emoji
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(fontSize: isSelected ? 16 : 14),
                            child: Text(option.emoji),
                          ),
                          const SizedBox(width: 8),
                          // Label with animation
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              fontSize: isSelected ? 13 : 12,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? MyColors.kCreamyWhite
                                  : MyColors.kPrimaryColor,
                              letterSpacing: isSelected ? 0.3 : 0,
                            ),
                            child: Text(option.label),
                          ),
                          // Checkmark for selected
                          if (isSelected) ...[
                            const SizedBox(width: 6),
                            AnimatedOpacity(
                              opacity: 1.0,
                              duration: const Duration(milliseconds: 200),
                              child: Icon(
                                Icons.check_circle,
                                size: 14,
                                color: MyColors.kCreamyWhite,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
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
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              _buildSuggestionChip('🧙‍♂️ Fantasy'),
              _buildSuggestionChip('🕵️ Mystery'),
              _buildSuggestionChip('💘 Romance'),
              _buildSuggestionChip('🚀 Sci-Fi'),
              _buildSuggestionChip('😱 Horror'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String label) {
    return InkWell(
      onTap: () {
        setState(() {
          _searchController.text = label.split(' ')[1];
          _isSearching = true;
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: MyColors.kCreamyWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: MyColors.kLightBrown),
          boxShadow: [
            BoxShadow(
              color: MyColors.kPrimaryColor.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: MyColors.kAccentBrown,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
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
        if (_selectedFilter != 'all' ||
            _selectedOrderBy != 'relevance' ||
            _selectedPrintType != 'all')
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

class _FilterOption {
  final String value;
  final String label;
  final String emoji;

  _FilterOption(this.value, this.label, this.emoji);
}
