import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/theme/fonts.dart';

import 'package:litlore/core/widgets/custom_error_widget.dart';
import 'package:litlore/core/widgets/flapping_owl_loading.dart';
import 'package:litlore/features/home/presentation/widgets/book_item.dart';
import 'package:litlore/features/search/manager/search_cubit.dart';
import 'package:litlore/features/search/manager/search_state.dart';
import 'package:litlore/features/search/presentation/widgets/empty_search_widget.dart';

class SearchingResults extends StatelessWidget {
  final TextEditingController searchController;
  const SearchingResults({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
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
                  '"${state.searchKey}"',
                  style: MyFonts.titleMediumStyle18.copyWith(
                    fontSize: 16,
                    color: MyColors.kPrimaryColor,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            if (state.status == SearchStatus.success)
              ListView.builder(
                itemCount: state.hadReachedMax
                    ? state.books?.books?.length
                    : state.books?.books?.length ?? 0 + 1,

                shrinkWrap: true, // ✅ مهم جدًا
                physics: const ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  if (index + 1 == state.books?.books?.length) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlappingOwlLoading(loadingText: ""),
                      ),
                    );
                  }
                  if (state.books != null ||
                      state.books?.books != null ||
                      state.books!.books!.isNotEmpty) {
                    return AnimationConfiguration.staggeredList(
                      duration: const Duration(milliseconds: 500),
                      position: index,
                      child: SlideAnimation(
                        horizontalOffset: 100,
                        child: FadeInAnimation(
                          child: BookItem(book: state.books!.books![index]),
                        ),
                      ),
                    );
                  } else {
                    return EmptySearchWidget(
                      title: "Nothing Found",
                      discreption: "Maybe it’s still being written.",
                    );
                  }
                },
              ),
            const SizedBox(height: 16),
            if (state.status == SearchStatus.loading)
              Center(
                child: FlappingOwlLoading(
                  loadingText:
                      'Our wisest owls are searching...\n Flipping through ${(searchController.text.length * 1000)} pages!',
                ),
              ),
            if (state.status == SearchStatus.failure)
              Center(
                child: CustomErrorWidget(
                  error: state.errorMessage!,
                  retryFunction: () async {
                    context.read<SearchCubit>().searchBooks(state.searchKey!);
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
