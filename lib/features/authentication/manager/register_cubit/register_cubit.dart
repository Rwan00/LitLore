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
      emit(state.copyWith(status: RegisterStatus.success, user: user));
    });
  }

  Future<void> checkEmailVerification() async {
    emit(state.copyWith(status: RegisterStatus.loading));
    var result = await authenticationRepo.checkEmailVerification();
    log("Checking email verification");
    result.fold((failure) {
      log("Email verification failed: $failure");
      emit(state.copyWith(
          status: RegisterStatus.failure, errorMessage: failure));
    }, (done) {
      log("Email verified and Google account linked successfully");
      emit(state.copyWith(status: RegisterStatus.success));
    });
  }

  Future<void> verifyEmail() async {
    var result = await authenticationRepo.verifyEmail();
    result.fold((failure) {
      emit(state.copyWith(
          status: RegisterStatus.failure, errorMessage: failure.errorMsg));
    }, (done) {
      log("Verification email sent");
    });
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(status: RegisterStatus.loading));
    var result = await authenticationRepo.signInWithGoogle();
    
    if (result == null) {
      // User cancelled Google sign-in
      emit(state.copyWith(status: RegisterStatus.initial));
      return;
    }
    
    result.fold((failure) {
      log("Google sign-in failed: ${failure.errorMsg}");
      emit(state.copyWith(
          status: RegisterStatus.failure, errorMessage: failure.errorMsg));
    }, (user) {
      log("Google sign-in successful");
      
      emit(state.copyWith(status: RegisterStatus.success, user: user));
    });
  }
}
