import 'package:flutter/material.dart';
import 'package:litlore/features/authentication/presentation/widgets/onboarding_stack_items.dart';
import 'package:litlore/features/authentication/presentation/widgets/page_view_widget.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {

    return const Column(
      children: [
        PageViewWidget(),
        OnboardingStackItems(),
      ],
    );
  }
}
