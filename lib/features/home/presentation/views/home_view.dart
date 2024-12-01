import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/assets.dart';
import 'package:litlore/features/home/presentation/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(AssetsData.logo),
        title: Text(
          "LitLoRe",
          style: MyFonts.logoStyle.copyWith(fontSize: 16),
        ),
        actions: [
          const Icon(FontAwesomeIcons.hatWizard),
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.magnifyingGlass),
          ),
        ],
      ),
      body: const HomeViewBody(),
    );
  }
}
