import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/features/authentication/data/repos/authentication_repo/authentication_repo_impl.dart';
import 'package:litlore/features/authentication/manager/onpage_change_cubit/onpage_change_cubit.dart';

import '../../../../core/utils/service_locator.dart';

import '../widgets/onboarding_view_body.dart';

class OnBoardingScreen extends StatelessWidget {
  static const routeName = "Onboarding view";
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnpageChangeCubit(ServiceLocator.getIt<AuthenticationRepoImpl>()),
      child: const Scaffold(
        body: OnboardingViewBody(),
      ),
    );
  }
}
