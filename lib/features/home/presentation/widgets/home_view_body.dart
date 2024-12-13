import 'package:flutter/material.dart';
import 'package:litlore/features/home/presentation/widgets/category_title.dart';
import 'package:litlore/features/home/presentation/widgets/discover_books_list.dart';
import 'package:litlore/features/home/presentation/widgets/newest_books_slider.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 12,
                  ),
                  child: CategoryTitle(
                    title: "Newest Books",
                  ),
                ),
                NewestBooksSlider(),
                Padding(
                  padding: EdgeInsets.only(
                    left: 12,
                  ),
                  child: CategoryTitle(title: "Discover Books"),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: DiscoverBooksList(),
          ),
        ],
      ),
    );
  }
}
