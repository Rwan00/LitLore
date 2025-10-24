import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:litlore/core/utils/service_locator.dart';
import 'package:litlore/features/search/data/repo/search_repo_impl.dart';
import 'package:litlore/features/search/manager/search_cubit.dart';

import 'package:litlore/features/search/presentation/widgets/search_view_body.dart';

import '../../../../core/utils/app_assets.dart';

class SearchView extends StatelessWidget {
  static const String routeName = "/SearchView";
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(ServiceLocator.getIt<SearchRepoImpl>()),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Image(image: AssetImage(AppAssets.wizard)),
            ),
          ],
        ),
        body: const SearchViewBody(),
      ),
    );
  }
}
