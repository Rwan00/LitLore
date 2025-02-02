import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:litlore/core/utils/app_assets.dart';
import 'package:litlore/features/authentication/data/repos/authentication_repo/authentication_repo_impl.dart';
import 'package:litlore/features/authentication/manager/onpage_change_cubit/onpage_change_cubit.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/utils/service_locator.dart';

import '../widgets/onboarding_stack_items.dart';

import '../widgets/page_view_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  static const routeName = "Onboarding view";
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OnpageChangeCubit(ServiceLocator.getIt<AuthenticationRepoImpl>()),
      child: Scaffold(
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppAssets.owlBackground,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: MyColors.kScaffoldColor,
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisSize: MainAxisSize.min,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
