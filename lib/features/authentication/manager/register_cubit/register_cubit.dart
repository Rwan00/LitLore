import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/features/authentication/data/repos/authentication_repo/authentication_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authenticationRepo) : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  final AuthenticationRepo authenticationRepo;

  Future<void> signUpWithEmail(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    var result = await authenticationRepo.signUpWithEmail(
        email: email, password: password);
    result.fold((failure) {
      log(failure.errorMsg);
      emit(RegisterFailure(errorMsg: failure.errorMsg));
    }, (user) {
      emit(RegisterSuccess(user: user));
    });
  }

  Future<void> checkEmailVerification() async {
    var result = await authenticationRepo.checkEmailVerification();
    result.fold((failure) {
      emit(VirificationFailure(errorMsg: failure));
    }, (done) {
      log("verified");
    });
  }
}
