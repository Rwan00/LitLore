import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../core/network/remote/authentication_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _showVerificationDialog(User user) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Verify Your Email'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('A verification email has been sent to:'),
            Text(user.email ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text('Please verify your email to continue.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _checkEmailVerification(user);
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  Future<void> _checkEmailVerification(User user) async {
    await user.reload();
    final updatedUser = _authService.currentUser;

    if (updatedUser != null && updatedUser.emailVerified) {
      final linkedUser = await _authService.linkGoogleAccount();
      if (linkedUser != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LibraryScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google account linking failed')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email not verified yet')),
      );
      _showVerificationDialog(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final email = _emailController.text.trim();
                final password = _passwordController.text.trim();
                final user = await _authService.signUpWithEmail(email, password);
                
                if (user != null) {
                  if (user.emailVerified) {
                    final linkedUser = await _authService.linkGoogleAccount();
                    if (linkedUser != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LibraryScreen()),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Verification email sent to ${user.email}'),
                        action: SnackBarAction(
                          label: 'Resend',
                          onPressed: () => user.sendEmailVerification(),
                        ),
                      ),
                    );
                    _showVerificationDialog(user);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sign-Up Failed')),
                  );
                }
              },
              child: const Text("Sign Up with Email"),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.g_mobiledata),
              label: const Text("Sign Up with Google"),
              onPressed: () async {
                final user = await _authService.signInWithGoogle();
                if (user != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LibraryScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Google Sign-Up Failed')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Add this new method to the AuthService class


// Rest of the code remains the same as previous corrected version

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List<dynamic> _books = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLibrary();
  }

  Future<void> _fetchLibrary() async {
    setState(() => _isLoading = true);

    try {
      final auth = AuthService();
      final user = auth.currentUser;
      
      // Verify Google authentication
      if (user == null || !user.providerData.any((info) => info.providerId == 'google.com')) {
        throw Exception('Google sign-in required to access library');
      }

      final token = await auth.getAccessToken();
      if (token == null) throw Exception("Failed to get access token");

      final response = await http.get(
        Uri.parse('https://www.googleapis.com/books/v1/mylibrary/bookshelves'),
        headers: {'Authorization': 'Bearer $token'},
      );

       log("TTTTTTTTOkkeeennn  $token");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _books = data['items'] ?? [];
          _isLoading = false;
        });
      } else if (response.statusCode == 401) {
        await auth.signOut();
        throw Exception('Session expired. Please sign in again.');
      } else {
        throw Exception('Failed to load library: ${response.statusCode}');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(title: const Text("My Library")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _books.isEmpty
              ? const Center(child: Text("No books in library"))
              : ListView.builder(
                  itemCount: _books.length,
                  itemBuilder: (context, index) {
                    final book = _books[index];
                    return ListTile(
                      title: Text(book['title'] ?? 'Untitled'),
                      subtitle: Text(book['authors']?.join(', ') ?? 'Unknown Author'),
                    );
                  },
                ),
    );
  }
}

