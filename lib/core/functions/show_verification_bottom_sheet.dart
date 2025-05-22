import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/app_assets.dart';
import 'package:litlore/core/utils/service_locator.dart';
import 'package:litlore/core/widgets/app_button_widget.dart';
import 'package:litlore/features/authentication/data/repos/authentication_repo/authentication_repo_impl.dart';
import 'package:litlore/features/authentication/manager/register_cubit/register_cubit.dart';
import 'package:litlore/features/authentication/manager/register_cubit/register_state.dart';

import 'show_bottom_sheet_function.dart';

void showVerificationBottomSheet({
  required BuildContext context,
}) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return _VerificationBottomSheetContent();
    },
  );
}

class _VerificationBottomSheetContent extends StatefulWidget {
  @override
  State<_VerificationBottomSheetContent> createState() =>
      _VerificationBottomSheetContentState();
}

class _VerificationBottomSheetContentState
    extends State<_VerificationBottomSheetContent> {
  late Timer _timer;
  int _countdown = 60;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _isButtonEnabled = false;
    _countdown = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown == 1) {
        timer.cancel();
        setState(() {
          _isButtonEnabled = true;
        });
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegisterCubit(ServiceLocator.getIt<AuthenticationRepoImpl>()),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.status == RegisterStatus.failure) {
            showBottomSheetFunction(context, state.errorMessage ?? "");
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Verify Your Email'),
                Image.asset(
                  AppAssets.owlError,
                  height: 60,
                  width: 60,
                ),
                const SizedBox(height: 10),
                Text(
                  "We’ve sent an email! Now go prove you're not a robot... or a plot twist",
                  textAlign: TextAlign.center,
                  style: MyFonts.textStyleStyle16.copyWith(
                    color: MyColors.kPrimaryColor,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: AppButtonWidget(
                        onPressed: _isButtonEnabled ? () {} : () {},
                        label: _isButtonEnabled
                            ? "Resend"
                            : "Resend in $_countdown s",
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: AppButtonWidget(
                        onPressed: _isButtonEnabled
                            ? () {
                                context
                                    .read<RegisterCubit>()
                                    .checkEmailVerification();
                              }
                            : () {},
                        label: "Turn the page",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
