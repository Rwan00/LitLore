import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:litlore/core/utils/service_locator.dart';
import 'package:litlore/core/widgets/custom_error_widget.dart';
import 'package:litlore/features/home/data/repos/home_repo/home_repo_impl.dart';
import 'package:litlore/features/home/manager/newest_books_cubit/newest_books_cubit.dart';

import '../../../../core/widgets/flapping_owl_loading.dart';
import 'book_image.dart';

class NewestBooksSlider extends StatelessWidget {
  const NewestBooksSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NewestBooksCubit(ServiceLocator.getIt<HomeRepoImpl>())
            ..fetchNewestBooks(),
      child: BlocBuilder<NewestBooksCubit, NewestBooksState>(
        builder: (context, state) {
          if (state is NewestBooksSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: state.books.map((book) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001), // perspective
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 2,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BookImage(
                            imgUrl:
                                book.volumeInfo?.imageLinks?.smallThumbnail ??
                                "",
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    //height: 280,
                    viewportFraction: 0.4,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.25,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    pauseAutoPlayOnTouch: true,
                  ),
                ),
              ],
            );
          } else if (state is NewestBooksFailure) {
            return CustomErrorWidget(
              error: state.errorMsg,
              retryFunction: () async {
                NewestBooksCubit.get(context).fetchNewestBooks();
              },
            );
          } else {
            return const FlappingOwlLoading();
          }
        },
      ),
    );
  }
}
