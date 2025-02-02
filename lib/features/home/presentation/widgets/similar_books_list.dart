import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/features/home/data/repos/book_details_repo/book_details_repo_impl.dart';


import '../../../../core/functions/size_functions.dart';
import '../../../../core/utils/service_locator.dart';

import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_loading_widget.dart';
import '../../manager/similar_books_cubit/similar_books_cubit.dart';
import 'book_image.dart';

class SimilarBooksList extends StatelessWidget {
  final String category;
  const SimilarBooksList({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SimilarBooksCubit(ServiceLocator.getIt<BookDetailsRepoImpl>())
            ..fetchSimilarBooks(category: category),
      child: BlocBuilder<SimilarBooksCubit, SimilarBooksState>(
        builder: (context, state) {
          if (state is SimilarBooksSuccess) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: height(context) * 0.16,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                        ),
                        child: BookImage(
                          imgUrl: state.books[index].volumeInfo.imageLinks
                                  ?.smallThumbnail ??
                              "",
                        ),
                      );
                    },
                    itemCount: 10,
                  ),
                ),
              ],
            );
          }
          if (state is SimilarBooksFailure) {
            return Center(
              child: CustomErrorWidget(
                error: state.errorMsg,
                retryFunction: () async {
                  SimilarBooksCubit.get(context)
                      .fetchSimilarBooks(category: category);
                },
              ),
            );
          } else {
            return const CustomLoadingWidget();
          }
        },
      ),
    );
  }
}
