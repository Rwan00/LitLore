import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


import '../../utils/app_consts.dart';

class GoogleSignInService {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final GoogleSignIn signIn = GoogleSignIn.instance;
  static bool isInitialize = false;

  static Future<void> initSignIn() async {
    if (!isInitialize) {
      await signIn.initialize(
        serverClientId:
            "437111373823-512vs5vcpfbp0romecseaf26d7k7l2sf.apps.googleusercontent.com",

        // ADD SCOPES HERE â¬‡ï¸
      );
    }
    isInitialize = true;
  }

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      await initSignIn(); // Await initSignIn()

    // 2. Perform the initial Google Sign-In (handles 'email' and 'profile' implicitly).
    final GoogleSignInAccount googleUser = await signIn.authenticate(); // User cancelled

    final idToken = googleUser.authentication.idToken;
    logger.i(idToken);

    final authorizationClient = googleUser.authorizationClient;

    // 3. CRITICAL FIX: Use authorizeScopes() to request the Books permission.
    // This will show the user a consent screen for the new scope if needed.
    GoogleSignInClientAuthorization? authorization = await authorizationClient
        .authorizeScopes([ // <-- CHANGED FROM authorizationForScopes
          'email',
          'profile',
          'https://www.googleapis.com/auth/books',
        ]);

    final accessToken = authorization.accessToken;

    // 4. Continue with Firebase authentication
    final credential = GoogleAuthProvider.credential(
      accessToken: accessToken, // Now guaranteed to be non-null
      idToken: idToken,
    );
       final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        final userDoc = FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid);
        final docSnapshot = await userDoc.get();
        if (!docSnapshot.exists) {
          await userDoc.set({
            "uid": user.uid,
            "name": user.displayName,
            "email": user.email,
            "photoUrl": user.photoURL,
            "provider": "google",
            "createdAt": FieldValue.serverTimestamp(),
          });
        }
      }
      return userCredential;
    } on GoogleSignInException catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  static Future<GoogleSignInAccount?> getGoogleSigninAccount() async {
    try {
      initSignIn();
      final GoogleSignInAccount googleUser = await signIn.authenticate();
      final idToken = googleUser.authentication.idToken;
      final authorizationClient = googleUser.authorizationClient;
      GoogleSignInClientAuthorization? authorization = await authorizationClient
          .authorizationForScopes([
            'email',
            'profile',
            'https://www.googleapis.com/auth/books',
          ]);

      final accessToken = authorization?.accessToken;
      if (accessToken == null) {
        final authorization2 = await authorizationClient.authorizationForScopes(
          ['email', 'profile', 'https://www.googleapis.com/auth/books'],
        );
        if (authorization2?.accessToken == null) {
          throw FirebaseAuthException(code: "Error");
        }
        authorization = authorization2;
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      final User? user = userCredential.user;
      if (user != null) {
        final userDoc = FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid);
        final docSnapshot = await userDoc.get();
        if (!docSnapshot.exists) {
          await userDoc.set({
            "uid": user.uid,
            "name": user.displayName,
            "email": user.email,
            "photoUrl": user.photoURL,
            "provider": "google",
            "createdAt": FieldValue.serverTimestamp(),
          });
        }
      }
      return googleUser;
    } on GoogleSignInException catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  static Future<void> signOut() async {
    try {
      await signIn.signOut();
      await auth.signOut();
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  static User? getCurrentUser() {
    return auth.currentUser;
  }
}
