import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/utils/app_assets.dart';

import 'package:litlore/features/search/manager/search_cubit.dart';
import 'package:litlore/features/search/manager/search_state.dart';

import 'package:litlore/features/search/presentation/widgets/filter_panel.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController searchController;
  final AnimationController animationController;
  final Animation<double> filterAnimation;

  const CustomSearchBar({
    super.key,
    required this.searchController,
    required this.animationController,
    required this.filterAnimation,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final cubit = context.read<SearchCubit>();
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: MyColors.kPrimaryColor.withAlpha(15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            controller: widget.searchController,
            onChanged: (value) {
              log(value);
              cubit.toggleSearching(value.isNotEmpty);
              cubit.setSearchingKey(value);
              cubit.searchBooks(value);
            },
            decoration: InputDecoration(
              hintText: 'Type a title, author, or just random words...',
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              prefixIcon: Image(image: AssetImage(AppAssets.search), width: 18),

              suffixIcon: widget.searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Image(
                        image: AssetImage(AppAssets.cancel),
                        width: 16,
                      ),
                      onPressed: () {
                        cubit.toggleSearching(false);
                        setState(() {
                          widget.searchController.clear();
                        });
                      },
                    )
                  : IconButton(
                onPressed: () {
                  showBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) => FilterPanel(
                      filterAnimation: widget.filterAnimation,
                      animationController: widget.animationController,
                    ),
                  );
                },
                icon: Image(image: AssetImage(AppAssets.filter), width: 24),
              ),

              filled: true,
              fillColor: MyColors.kCreamyWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: MyColors.kLightBrown.withAlpha(30),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: MyColors.kPrimaryColor,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}
