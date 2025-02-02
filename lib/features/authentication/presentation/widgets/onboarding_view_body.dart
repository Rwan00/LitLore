import 'package:flutter/material.dart';
import 'package:litlore/core/functions/size_functions.dart';
import 'package:litlore/features/authentication/presentation/widgets/custom_container_widget.dart';
import 'package:litlore/features/authentication/presentation/widgets/onboarding_stack_items.dart';
import 'package:litlore/features/authentication/presentation/widgets/page_view_widget.dart';

import '../../../../core/utils/app_assets.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainerWidget(
      containerHeight: height(context) * 0.45,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(
              AppAssets.logo,
            ),
            width: 80,
          ),
          PageViewWidget(),
          OnboardingStackItems(),
        ],
      ),
    );
  }
}
