import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/core/utils/service_locator.dart';
import 'package:litlore/features/authentication/manager/auth_cubit/auth_cubit.dart';
import 'package:litlore/features/authentication/presentation/widgets/login_view_body.dart';


import '../../data/repos/authentication_repo_impl.dart';

class LoginView extends StatelessWidget {
  static const routeName = "/LoginView";
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(ServiceLocator.getIt<AuthenticationRepoImpl>()),
      child: const Scaffold(
        body: LoginViewBody(),
      ),
    );
  }
}