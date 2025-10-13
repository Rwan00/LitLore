import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/core/utils/service_locator.dart';
import 'package:litlore/features/authentication/manager/register_cubit/register_cubit.dart';
import 'package:litlore/features/authentication/presentation/widgets/register_view_body.dart';

import '../../data/repos/authentication_repo/authentication_repo_impl.dart';

class RegisterView extends StatelessWidget {
  static const routeName = "/RegisterView";
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(ServiceLocator.getIt<AuthenticationRepoImpl>()),
      child: const Scaffold(
        body: RegisterViewBody(),
      ),
    );
  }
}
