import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: ()async{
          final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['https://www.googleapis.com/auth/books'],
);

try {
    final account = await _googleSignIn.signIn();
    if (account != null) {
      final authHeaders = await account.authHeaders;
      print('Access Token: ${authHeaders['Authorization']}');
      // Use this token to call My Library API
    }
  } catch (error) {
    print('Error signing in: $error');
  }
        }, child: Text("Sign-In")),
      ),
    );
  }
}