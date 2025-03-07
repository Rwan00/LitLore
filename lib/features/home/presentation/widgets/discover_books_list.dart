import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:litlore/features/home/manager/discover_books_cubit/discover_books_cubit.dart';

import '../../../../core/utils/service_locator.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/flapping_owl_loading.dart';
import '../../data/repos/home_repo/home_repo_impl.dart';
import 'book_item.dart';

class DiscoverBooksList extends StatelessWidget {
  const DiscoverBooksList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DiscoverBooksCubit(ServiceLocator.getIt<HomeRepoImpl>())
            ..fetchDiscoverBooks(),
      child: BlocBuilder<DiscoverBooksCubit, DiscoverBooksState>(
        builder: (context, state) {
          if (state is DiscoverBooksFailure) {
            return CustomErrorWidget(
              error: state.errorMsg,
              retryFunction: () async {
                DiscoverBooksCubit.get(context).fetchDiscoverBooks();
              },
            );
          } else if (state is DiscoverBooksSuccess) {
            return Column(
              children: List.generate(
                state.books.length,
                (index) => BookItem(book: state.books[index]),
              ),
            );
          } else {
            return const FlappingOwlLoading();
          }
        },
      ),
    );
  }
}
