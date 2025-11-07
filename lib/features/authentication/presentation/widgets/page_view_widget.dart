import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/features/authentication/manager/onpage_change_cubit/onpage_change_cubit.dart';

import '../../data/models/onboarding_model.dart';
import 'onboarding_item_widget.dart';

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnpageChangeCubit, OnpageChangeState>(
      builder: (context, state) {
        var cubit = OnpageChangeCubit.get(context);
        return Expanded(
          child: PageView.builder(
            controller: cubit.pageController,
            onPageChanged: (int index) {
              cubit.onPageChange(index: index);
            },
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                OnboardingItemWidget(onBoardingModel: onBoardingList[index]),
            itemCount: onBoardingList.length,
          ),
        );
      },
    );
  }
}
