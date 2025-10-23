import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/core/functions/size_functions.dart';
import 'package:litlore/core/network/local/navigation_services.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/widgets/app_button_widget.dart';
import 'package:litlore/core/widgets/flapping_owl_loading.dart';
import 'package:litlore/features/authentication/manager/auth_cubit/auth_cubit.dart';
import 'package:litlore/features/authentication/manager/auth_cubit/auth_state.dart';
import 'package:litlore/features/authentication/presentation/widgets/custom_container_widget.dart';
import 'package:litlore/features/authentication/presentation/widgets/form_title_widget.dart';

import 'package:litlore/features/authentication/presentation/views/register_view.dart';
import 'package:litlore/features/authentication/presentation/widgets/login_form.dart';

import '../../../../core/functions/show_bottom_sheet_function.dart';

import 'google_signing_btn.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainerWidget(
      containerHeight: height(context) * 0.73,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FormTitleWidget(),
              LoginForm(email: _email, password: _password),
              const SizedBox(height: 12),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state.status == AuthStatus.failure) {
                    showBottomSheetFunction(context, state.errorMessage ?? "");
                  }
                },
                builder: (context, state) {
                  var cubit = context.read<AuthCubit>();
                  return state.status == AuthStatus.loading
                      ? Center(child: FlappingOwlLoading())
                      : Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: AppButtonWidget(
                                label: 'Open the Book!',
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await cubit.signInWithEmail(
                                      email: _email.text,
                                      password: _password.text,
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            GoogleSigningBtn(
                              onPressed: () {
                                cubit.signInWithGoogle();
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'New reader in town?',
                                  style: MyFonts.titleMediumStyle18.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    NavigationService.pushReplacement(
                                      RegisterView.routeName,
                                    );
                                  },
                                  child: Text(
                                    'Get your library card!',
                                    style: MyFonts.subTiltleStyle14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
