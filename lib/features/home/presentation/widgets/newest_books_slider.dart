import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/core/utils/app_assets.dart';
import 'package:litlore/core/utils/service_locator.dart';
import 'package:litlore/core/widgets/custom_error_widget.dart';
import 'package:litlore/features/home/data/repos/home_repo/home_repo_impl.dart';
import 'package:litlore/features/home/manager/newest_books_cubit/newest_books_cubit.dart';

import 'category_title.dart';
import 'book_image.dart';

class NewestBooksSlider extends StatelessWidget {
  final List imgList;
  const NewestBooksSlider({super.key, required this.imgList});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NewestBooksCubit(ServiceLocator.getIt<HomeRepoImpl>())..fetchNewestBooks(),
      child: BlocBuilder<NewestBooksCubit, NewestBooksState>(
        builder: (context, state) {
          if (state is NewestBooksFailure) {
            return CustomErrorWidget(error: state.errorMsg);
          } else if (state is NewestBooksSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    left: 12,
                  ),
                  child: CategoryTitle(
                    title: "Newest Books",
                  ),
                ),
                CarouselSlider(
                  items: imgList.map((imgURL) {
                    return BookImage(imgUrl: imgURL);
                  }).toList(),
                  options: CarouselOptions(
                    aspectRatio: 1.67,
                    viewportFraction: 0.4,
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
            return const Center(
              child: Image(
                image: AssetImage(
                  AssetsData.loading,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
