import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:litlore/core/utils/service_locator.dart';
import 'package:litlore/core/widgets/custom_error_widget.dart';
import 'package:litlore/features/home/data/repos/home_repo/home_repo_impl.dart';
import 'package:litlore/features/home/manager/newest_books_cubit/newest_books_cubit.dart';

import '../../../../core/widgets/custom_loading_widget.dart';
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
          if (state is NewestBooksFailure) {
            return CustomErrorWidget(
              error: state.errorMsg,
              retryFunction: () async {
                NewestBooksCubit.get(context).fetchNewestBooks();
              },
            );
          } else if (state is NewestBooksSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  items: state.books.map((book) {
                    return BookImage(
                      imgUrl: book.volumeInfo.imageLinks?.smallThumbnail??"",
                    );
                  }).toList(),
                  options: CarouselOptions(
                    aspectRatio: 2,
                    viewportFraction: 0.35,
                    initialPage: 0,
                    enlargeCenterPage: true,
                    pauseAutoPlayOnManualNavigate: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                    disableCenter: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                  ),
                ),
              ],
            );
          } else {
            return const CustomLoadingWidget();
          }
        },
      ),
    );
  }
}
