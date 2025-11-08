import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:litlore/core/functions/size_functions.dart';
import 'package:litlore/core/theme/fonts.dart';

import 'package:litlore/core/widgets/custom_error_widget.dart';
import 'package:litlore/core/widgets/flapping_owl_loading.dart';

import 'package:litlore/features/home/manager/shelf_books_cubit.dart/shelf_books_cubit.dart';
import 'package:litlore/features/home/manager/shelf_books_cubit.dart/shelf_books_state.dart';
import 'package:litlore/features/home/presentation/views/book_details_view.dart';
import 'package:litlore/features/home/presentation/widgets/book_image.dart';

import 'package:litlore/features/search/presentation/widgets/empty_search_widget.dart';

class ShelfBooksBody extends StatefulWidget {
  final int shelfId;
  const ShelfBooksBody({super.key, required this.shelfId});

  @override
  State<ShelfBooksBody> createState() => _ShelfBooksBodyState();
}

class _ShelfBooksBodyState extends State<ShelfBooksBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      final cubit = context.read<ShelfBooksCubit>();
      if (!cubit.state.hadReachedMax &&
          cubit.state.status != ShelfBooksStatus.loadingMore) {
        cubit.loadMore(widget.shelfId);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShelfBooksCubit, ShelfBooksState>(
      builder: (context, state) {
        return SingleChildScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state.status == ShelfBooksStatus.success ||
                  state.status == ShelfBooksStatus.loadingMore)
                BooksGrid(state: state),
              const SizedBox(height: 16),
              if (state.status == ShelfBooksStatus.loading)
                Center(child: FlappingOwlLoading()),
              if (state.status == ShelfBooksStatus.failure)
                Center(
                  child: CustomErrorWidget(
                    error: state.errorMessage!,
                    retryFunction: () async {
                      context.read<ShelfBooksCubit>().fetchShelfBooks(
                        widget.shelfId,
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

class BooksGrid extends StatelessWidget {
  final ShelfBooksState state;
  const BooksGrid({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final books = state.books?.books ?? [];

    if (books.isEmpty) {
      return EmptySearchWidget(
        title: "Nothing Found",
        discreption: "Maybe it's still being written.",
      );
    }

    return Column(
      children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Number of columns
            childAspectRatio: 0.3, // Adjust based on your book item design
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: books.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemBuilder: (BuildContext context, int index) {
            final book = books[index];
            return AnimationConfiguration.staggeredGrid(
              duration: const Duration(milliseconds: 500),
              position: index,
              columnCount: 3,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () {
                      context.push(
                        BookDetailsView.routeName,
                        extra: {"book": book},
                      );
                    },
                    child: Column(
                      children: [
                        Hero(
                          tag: book.id,
                          child: BookImage(book: book),
                        ),
                        SizedBox(height: height(context) * 0.01),
                        SizedBox(
                          width: width(context) * 0.54,
                          child: Text(
                            book.volumeInfo?.title ??
                                "Nameless, but still legendary.",
                            style: MyFonts.textStyleStyle16,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        // Show loading indicator when loading more
        if (!state.hadReachedMax &&
            state.status == ShelfBooksStatus.loadingMore)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: FlappingOwlLoading()),
          ),
      ],
    );
  }
}
