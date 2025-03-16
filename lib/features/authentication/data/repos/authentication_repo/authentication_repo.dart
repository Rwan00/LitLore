import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/errors/failures.dart';

abstract class AuthenticationRepo {
  bool onPageChange({required int index});
  Future<Either<Failures,User?>> signUpWithEmail({required String email,required String password});
  Future<Either<String,void>> checkEmailVerification();
  Future<Either<Failures,User?>?> linkGoogleAccount();
}
