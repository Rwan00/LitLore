import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/features/authentication/data/repos/authentication_repo/authentication_repo.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authenticationRepo) : super(RegisterState.initial());

  final AuthenticationRepo authenticationRepo;

  Future<void> signUpWithEmail(
      {required String email, required String password}) async {
    emit(state.copyWith(status: RegisterStatus.loading));
    var result = await authenticationRepo.signUpWithEmail(
        email: email, password: password);
    result.fold((failure) {
      log(failure.errorMsg);
      emit(state.copyWith(
          status: RegisterStatus.failure, errorMessage: failure.errorMsg));
    }, (user) {
      emit(state.copyWith(status: RegisterStatus.success));
    });
  }

  Future<void> checkEmailVerification() async {
    var result = await authenticationRepo.checkEmailVerification();
    log("pressed");
    result.fold((failure) {
      emit(state.copyWith(
          status: RegisterStatus.failure, errorMessage: failure));
    }, (done) {
      log("verified");
      emit(state.copyWith(status: RegisterStatus.success));
    });
  }

  Future<void> verifyEmail() async {
    var result = await authenticationRepo.verifyEmail();
    result.fold((failure) {
      emit(state.copyWith(
          status: RegisterStatus.failure, errorMessage: failure.errorMsg));
    }, (done) {});
  }

  Future<void> signInWithGoogle() async {
    var result = await authenticationRepo.signInWithGoogle();
    result?.fold((failure) {
      state.copyWith(
          status: RegisterStatus.failure, errorMessage: failure.errorMsg);
    }, (success) {
      state.copyWith(status: RegisterStatus.success);
    });
  }
}
