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
            return SliverToBoxAdapter(
              child: CustomErrorWidget(
                error: state.errorMsg,
                retryFunction: () async {
                  DiscoverBooksCubit.get(context).fetchDiscoverBooks();
                },
              ),
            );
          } else if (state is DiscoverBooksSuccess) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 300 + (index * 100)),
                    tween: Tween(begin: 0.0, end: 1.0),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 50 * (1 - value)),
                        child: Opacity(
                          opacity: value,
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: index == state.books.length - 1 ? 0 : 16,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 15,
                                    spreadRadius: 0,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BookItem(book: state.books[index]),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                childCount: state.books.length,
              ),
            );
          } else {
            return const SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: Center(child: FlappingOwlLoading()),
              ),
            );
          }
        },
      ),
    );
  }
}