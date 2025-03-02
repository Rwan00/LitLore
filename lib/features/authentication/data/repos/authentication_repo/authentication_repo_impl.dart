

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../../core/errors/failures.dart';
import '../../models/onboarding_model.dart';
import 'authentication_repo.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {
 

  @override
  bool onPageChange({ required int index}) {
    bool isLast = false;
    if (index == onBoardingList.length - 1) {
      isLast = true;
      
    } else {
      isLast = false;
    }
    return isLast;
  }
  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['https://www.googleapis.com/auth/books'],
  );
  
  @override
  Future<Either<Failures,User?>> signUpWithEmail({required String email,required String password}) async {
    try {
      UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //await userCredential.user?.sendEmailVerification();
      
      return right(userCredential.user);
    } on FirebaseAuthException catch(err){
      log(err.toString());
      return left(FirebaseAuthFailure.fromFirebaseAuthException(err));
    }
   catch (error) {
      return left(
        FirebaseAuthFailure(
          errorMsg: error.toString(),
        ),
      );
    }
  }
 
}
