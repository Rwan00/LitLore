import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/core/theme/fonts.dart';

import 'package:litlore/core/utils/service_locator.dart';

import 'package:litlore/features/home/data/repos/home_repo/home_repo_impl.dart';
import 'package:litlore/features/home/manager/shelf_books_cubit.dart/shelf_books_cubit.dart';
import 'package:litlore/features/home/presentation/widgets/shelf_books_body.dart';

import 'package:nb_utils/nb_utils.dart';

class ShelfBooksView extends StatelessWidget {
  final String title;
  final int shelfId;
  const ShelfBooksView({super.key, required this.title, required this.shelfId});
  static const routeName = "/ShelfBooksView";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShelfBooksCubit(ServiceLocator.getIt<HomeRepoImpl>())
            ..fetchShelfBooks(shelfId),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: MyFonts.titleMediumStyle18.copyWith(fontSize: 24),
          ),
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ShelfBooksBody(shelfId: shelfId),
          ),
        ),
      ),
    );
  }
}
