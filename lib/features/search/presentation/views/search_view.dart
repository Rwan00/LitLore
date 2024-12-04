import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:litlore/core/utils/app_methods.dart';
import 'package:litlore/features/search/presentation/widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  static const String routeName = "Search View";
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            viewPop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.hatWizard),
          ),
        ],
      ),
      body: const SearchViewBody(),
    );
  }
}
