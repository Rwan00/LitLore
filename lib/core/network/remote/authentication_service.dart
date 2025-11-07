/* import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // static final AuthService _instance = AuthService._internal();
  // factory AuthService() => _instance;
  // AuthService._internal();

  
  String? _accessToken;
  DateTime? _tokenExpiryTime;

  User? get currentUser => _auth.currentUser;

  

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      _accessToken = googleAuth.accessToken;
      log("TTTTTTTTOkkeeennn $_accessToken");
      _tokenExpiryTime = DateTime.now().add(const Duration(hours: 1));

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      return _auth.currentUser;
    } catch (e) {
      print('Google Sign-In Error: $e');
      return null;
    }
  }

  Future<User?> linkGoogleAccount() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Link Google credential to email/password account
      await _auth.currentUser?.linkWithCredential(credential);

      // Update token information
      _accessToken = googleAuth.accessToken;
      _tokenExpiryTime = DateTime.now().add(const Duration(hours: 1));

      return _auth.currentUser;
    } catch (e) {
      print('Error linking Google account: $e');
      return null;
    }
  }

  Future<String?> getAccessToken() async {
    if (_accessToken != null &&
        _tokenExpiryTime != null &&
        DateTime.now().isBefore(_tokenExpiryTime!)) {
      return _accessToken;
    }
    return _refreshToken();
  }

  Future<String?> _refreshToken() async {
    try {
      // Check if there's a current Google user
      if (_googleSignIn.currentUser == null) return null;

      final GoogleSignInAccount? googleUser =
          await _googleSignIn.signInSilently();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      _accessToken = googleAuth.accessToken;
      _tokenExpiryTime = DateTime.now().add(const Duration(hours: 1));
      return _accessToken;
    } catch (e) {
      print('Token refresh error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    _accessToken = null;
    _tokenExpiryTime = null;
  }
}
  */
