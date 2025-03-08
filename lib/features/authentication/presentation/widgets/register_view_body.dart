import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/core/functions/size_functions.dart';

import 'package:litlore/core/theme/fonts.dart';

import 'package:litlore/core/widgets/app_button_widget.dart';
import 'package:litlore/core/widgets/flapping_owl_loading.dart';

import 'package:litlore/features/authentication/presentation/widgets/custom_container_widget.dart';
import 'package:litlore/features/authentication/presentation/widgets/form_title_widget.dart';
import 'package:litlore/features/authentication/presentation/widgets/register_form.dart';

import '../../../../core/functions/show_bottom_sheet_function.dart';
import '../../manager/register_cubit/register_cubit.dart';
import 'google_signing_btn.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainerWidget(
      containerHeight: height(context) * 0.73,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FormTitleWidget(),
            RegisterForm(
              email: _email,
              password: _password,
            ),
            const SizedBox(
              height: 12,
            ),
            BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state is RegisterFailure) {
                  showBottomSheetFunction(context, state.errorMsg);
                }
              },
              builder: (context, state) {
                var cubit = RegisterCubit.get(context);
                return state is RegisterLoading
                    ? Center(
                        child: FlappingOwlLoading(),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: AppButtonWidget(
                              label: 'Join the Story!',
                              onPressed: () async {
                                await cubit.signUpWithEmail(
                                  email: _email.text,
                                  password: _password.text,
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          GoogleSigningBtn(onPressed: () {}),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have a library card?',
                                style: MyFonts.titleMediumStyle18
                                    .copyWith(fontSize: 16),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Login and reunite!',
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
    );
  }
}

TextEditingController _email = TextEditingController();
TextEditingController _password = TextEditingController();
