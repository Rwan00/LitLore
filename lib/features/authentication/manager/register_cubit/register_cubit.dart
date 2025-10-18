import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/core/network/local/cache_helper.dart';
import 'package:litlore/core/network/local/navigation_services.dart';
import 'package:litlore/features/authentication/data/repos/authentication_repo/authentication_repo.dart';
import 'package:litlore/features/home/presentation/views/home_view.dart';
import 'package:litlore/features/authentication/presentation/views/onboarding_view.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authenticationRepo) : super(RegisterState.initial());

  final AuthenticationRepo authenticationRepo;

  /// Saves access and refresh tokens to secure cache
  Future<void> _saveTokens({
    required String? accessToken,
    required String? refreshToken,
  }) async {
    try {
      if (accessToken != null && accessToken.isNotEmpty) {
        await AppCacheHelper.cacheSecureString(
          key: AppCacheHelper.accessTokenKey,
          value: accessToken,
        );
        log('✅ Access token saved to cache');
      }

      if (refreshToken != null && refreshToken.isNotEmpty) {
        await AppCacheHelper.cacheSecureString(
          key: AppCacheHelper.refreshTokenKey,
          value: refreshToken,
        );
        log('✅ Refresh token saved to cache');
      }
    } catch (e) {
      log('❌ Error saving tokens: $e');
    }
  }

  /// Extracts tokens from Firebase user and saves them
  Future<void> _handleUserAuthentication(dynamic user) async {
    try {
      if (user != null) {
        // Get Firebase ID token (acts as access token)
        final idToken = await user.getIdToken();

        // Save tokens
        await _saveTokens(
          accessToken: idToken,
          refreshToken: user.refreshToken,
        );

        log('🔐 User authenticated: ${user.email}');
      }
    } catch (e) {
      log('❌ Error handling user authentication: $e');
    }
  }

  /// Sign up with email and password
  Future<void> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: RegisterStatus.loading));

    try {
      var result = await authenticationRepo.signUpWithEmail(
        email: email,
        password: password,
      );

      result.fold(
        (failure) {
          log('❌ Sign up failed: ${failure.errorMsg}');
          emit(
            state.copyWith(
              status: RegisterStatus.failure,
              errorMessage: failure.errorMsg,
            ),
          );
        },
        (user) async {
          log('✅ Sign up successful');

          await checkEmailVerification();
          emit(state.copyWith(status: RegisterStatus.success, user: user));
        },
      );
    } catch (e) {
      log('❌ Exception in signUpWithEmail: $e');
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: 'Sign up failed: $e',
        ),
      );
    }
  }

  /// Verify email and link Google account
  Future<void> checkEmailVerification() async {
    emit(state.copyWith(status: RegisterStatus.loading));

    try {
      var result = await authenticationRepo.checkEmailVerification();

      result.fold(
        (failure) {
          log('❌ Email verification failed: $failure');
          emit(
            state.copyWith(
              status: RegisterStatus.failure,
              errorMessage: failure,
            ),
          );
        },
        (done) {
          log('✅ Email verified and Google account linked successfully');
          emit(state.copyWith(status: RegisterStatus.success));
          
          // Navigate to home after successful verification
          _navigateToHome();
        },
      );
    } catch (e) {
      log('❌ Exception in checkEmailVerification: $e');
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: 'Verification check failed: $e',
        ),
      );
    }
  }

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    emit(state.copyWith(status: RegisterStatus.loading));

    try {
      var result = await authenticationRepo.signInWithGoogle();

      // User cancelled Google sign-in
      if (result == null) {
        log('ℹ️ Google sign-in cancelled by user');
        emit(state.copyWith(status: RegisterStatus.initial));
        return;
      }

      result.fold(
        (failure) {
          log('❌ Google sign-in failed: ${failure.errorMsg}');
          emit(
            state.copyWith(
              status: RegisterStatus.failure,
              errorMessage: failure.errorMsg,
            ),
          );
        },
        (user) async {
          log('✅ Google sign-in successful');

          // Handle authentication and save tokens
          await _handleUserAuthentication(user);

          emit(state.copyWith(status: RegisterStatus.success, user: user));

          // Navigate to home
          _navigateToHome();
        },
      );
    } catch (e) {
      log('❌ Exception in signInWithGoogle: $e');
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: 'Google sign-in failed: $e',
        ),
      );
    }
  }

  /// Navigate to home screen
  void _navigateToHome() {
    Future.delayed(const Duration(milliseconds: 500), () {
      NavigationService.pushReplacement(HomeView.routeName);
    });
  }

  /// Sign out user and clear tokens
  Future<void> signOut() async {
    try {
      log('🚪 Signing out user...');
      await AppCacheHelper.signOut();
      emit(RegisterState.initial());

      // Navigate to onboarding
      NavigationService.pushReplacement(OnBoardingScreen.routeName);
      log('✅ Sign out successful');
    } catch (e) {
      log('❌ Error during sign out: $e');
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: 'Sign out failed: $e',
        ),
      );
    }
  }

  /// Debug method to check stored tokens
  Future<void> debugTokens() async {
    final accessToken = await AppCacheHelper.getSecureString(
      key: AppCacheHelper.accessTokenKey,
    );
    final refreshToken = await AppCacheHelper.getSecureString(
      key: AppCacheHelper.refreshTokenKey,
    );

    log('🔍 Debug Tokens:');
    log(
      '  Access Token: ${accessToken.isEmpty ? 'EMPTY' : 'EXISTS (${accessToken.length} chars)'}',
    );
    log(
      '  Refresh Token: ${refreshToken.isEmpty ? 'EMPTY' : 'EXISTS (${refreshToken.length} chars)'}',
    );
  }
}
