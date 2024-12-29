import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/core/widgets/app_button_widget.dart';
import 'package:litlore/features/authentication/manager/onpage_change_cubit/onpage_change_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/fonts.dart';
import '../../../../core/utils/app_methods.dart';
import '../../data/models/onboarding_model.dart';
import '../views/register_view.dart';

class OnboardingStackItems extends StatelessWidget {
  const OnboardingStackItems({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnpageChangeCubit, OnpageChangeState>(
      builder: (context, state) {
        var cubit = OnpageChangeCubit.get(context);
        return Column(
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
            const SizedBox(
              height: 60,
            ),
            AppButtonWidget(
              onPressed: () {
                if (cubit.isLast) {
                  log("true");
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
              width: 140,
              label: "Next",
            ),
            TextButton(
              onPressed: () {
                /*   goToPage(
                        context: context,
                        routeName: RegisterView.routeName,
                        delete: true,
                      ); */
              },
              child: Text(
                "Already have an account?",
                style: MyFonts.logoStyle.copyWith(
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
