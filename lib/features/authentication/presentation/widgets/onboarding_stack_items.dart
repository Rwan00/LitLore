import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:litlore/features/authentication/manager/onpage_change_cubit/onpage_change_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/functions/navigations_functions.dart';
import '../../../../core/theme/colors.dart';

import '../../data/models/onboarding_model.dart';
import '../views/register_view.dart';

class OnboardingStackItems extends StatelessWidget {
  const OnboardingStackItems({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnpageChangeCubit, OnpageChangeState>(
      builder: (context, state) {
        var cubit = OnpageChangeCubit.get(context);
        return Row(
          children: [
            SmoothPageIndicator(
              controller: cubit.pageController,
              count: onBoardingList.length,
              effect: const SwapEffect(
                activeDotColor: MyColors.kPrimaryColor,
                dotWidth: 12,
                dotHeight: 8,
              ),
            ),
            const Spacer(),
            FloatingActionButton(
              backgroundColor: MyColors.kPrimaryColor,
              onPressed: () {
                if (cubit.isLast) {
                  goToPage(
                    context: context,
                    routeName: RegisterView.routeName,
                    delete: true,
                  );
                } else {
                  cubit.pageController.nextPage(
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.easeInOutBack,
                  );
                }
              },
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
