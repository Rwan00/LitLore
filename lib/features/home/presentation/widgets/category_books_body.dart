import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:litlore/core/widgets/custom_error_widget.dart';
import 'package:litlore/core/widgets/flapping_owl_loading.dart';
import 'package:litlore/features/home/manager/category_books_cubit.dart/category_books_cubit.dart';
import 'package:litlore/features/home/manager/category_books_cubit.dart/category_books_state.dart';
import 'package:litlore/features/home/presentation/widgets/book_item.dart';
import 'package:litlore/features/search/presentation/widgets/empty_search_widget.dart';

class CategoryBooksBody extends StatefulWidget {
  final String title;
  const CategoryBooksBody({super.key, required this.title});

  @override
  State<CategoryBooksBody> createState() => _CategoryBooksBodyState();
}

class _CategoryBooksBodyState extends State<CategoryBooksBody> {
  final ScrollController _scrollController = ScrollController();
  _onScroll() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!context.read<CategoryBooksCubit>().state.hadReachedMax) {
          context.read<CategoryBooksCubit>().loadMore(widget.title);
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onScroll();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBooksCubit, CategoryBooksState>(
      builder: (context, state) {
        return SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              if (state.status == CategoryBooksStatus.success)
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
                          child: FlappingOwlLoading(),
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
              if (state.status == CategoryBooksStatus.loading)
                Center(child: FlappingOwlLoading()),
              if (state.status == CategoryBooksStatus.failure)
                Center(
                  child: CustomErrorWidget(
                    error: state.errorMessage!,
                    retryFunction: () async {
                      context.read<CategoryBooksCubit>().fetchCategoryBooks(
                        widget.title,
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
