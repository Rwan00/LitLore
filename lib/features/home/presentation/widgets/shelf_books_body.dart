import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:litlore/core/widgets/custom_error_widget.dart';
import 'package:litlore/core/widgets/flapping_owl_loading.dart';

import 'package:litlore/features/home/manager/shelf_books_cubit.dart/shelf_books_cubit.dart';
import 'package:litlore/features/home/manager/shelf_books_cubit.dart/shelf_books_state.dart';
import 'package:litlore/features/home/presentation/widgets/book_item.dart';
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
    // ✅ Add listener directly in initState
    _scrollController.addListener(_onScroll);
  }

  // ✅ Fixed scroll listener
  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      final cubit = context.read<ShelfBooksCubit>();
      if (!cubit.state.hadReachedMax && cubit.state.status != ShelfBooksStatus.loadingMore) {
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
                _buildBooksList(state),
              const SizedBox(height: 16),
              if (state.status == ShelfBooksStatus.loading)
                Center(child: FlappingOwlLoading()),
              if (state.status == ShelfBooksStatus.failure)
                Center(
                  child: CustomErrorWidget(
                    error: state.errorMessage!,
                    retryFunction: () async {
                      context.read<ShelfBooksCubit>().fetchShelfBooks(widget.shelfId);
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBooksList(ShelfBooksState state) {
    final books = state.books?.books ?? [];
    
    if (books.isEmpty) {
      return EmptySearchWidget(
        title: "Nothing Found",
        discreption: "Maybe it's still being written.",
      );
    }

    // ✅ Fixed itemCount - add parentheses and show loader when loading more
    final itemCount = state.hadReachedMax ? books.length : books.length + 1;

    return ListView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        // ✅ Show loading indicator at the end when loading more
        if (index == books.length) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlappingOwlLoading(),
            ),
          );
        }

        return AnimationConfiguration.staggeredList(
          duration: const Duration(milliseconds: 500),
          position: index,
          child: SlideAnimation(
            horizontalOffset: 100,
            child: FadeInAnimation(
              child: BookItem(book: books[index]),
            ),
          ),
        );
      },
    );
  }
}