import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/app_assets.dart';
import 'package:litlore/core/utils/app_methods.dart';
import 'package:litlore/features/home/presentation/widgets/home_view_body.dart';

import '../../../search/presentation/views/search_view.dart';

class HomeView extends StatelessWidget {
  static const routeName = "/HomeView";
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.transparent,
        leading: Image.asset(AssetsData.logo),
        title: Text(
          "LitLoRe",
          style: MyFonts.logoStyle.copyWith(fontSize: 16),
        ),
        actions: [
          const Icon(FontAwesomeIcons.hatWizard),
          IconButton(
            onPressed: () {
              goToPage(
                context: context,
                routeName: SearchView.routeName,
                delete: false,
              );
            },
            icon: const Icon(FontAwesomeIcons.magnifyingGlass),
          ),
        ],
      ),
      body: const HomeViewBody(),
    );
  }
}
