

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utils/app_consts.dart';

class GoogleSignInService{
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final GoogleSignIn signIn = GoogleSignIn.instance;
 static  bool isInitialize = false;

 static Future<void> initSignIn() async{
   if(!isInitialize){
     await signIn.initialize(
       serverClientId: "437111373823-hv41m68mvg50bvf2ntngjo88atvkg1vf.apps.googleusercontent.com",
     );
   }
   isInitialize = true;
 }

 static Future<UserCredential?> signInWithGoogle() async {
   try{
     initSignIn();
     final GoogleSignInAccount googleUser = await signIn.authenticate();
     final idToken = googleUser.authentication.idToken;
     final authorizationClient = googleUser.authorizationClient;
     GoogleSignInClientAuthorization? authorization = await authorizationClient.authorizationForScopes([  'https://www.googleapis.com/auth/books',
       'email',
       'profile'],);

     final accessToken  = authorization?.accessToken;
     if(accessToken == null){
       final authorization2 = await authorizationClient.authorizationForScopes([
         'https://www.googleapis.com/auth/books',
         'email',
         'profile'],);
       if(authorization2?.accessToken == null){
         throw FirebaseAuthException(code: "Error");
       }
       authorization = authorization2;
     }
     final credential = GoogleAuthProvider.credential(
       accessToken: accessToken,
       idToken: idToken,
     );
     final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
     final User? user = userCredential.user;
     if(user != null){
       final userDoc = FirebaseFirestore.instance.collection("users").doc(user.uid);
       final docSnapshot = await userDoc.get();
       if(!docSnapshot.exists){
         await userDoc.set({
           "uid":user.uid,
           "name":user.displayName,
           "email":user.email,
           "photoUrl":user.photoURL,
           "provider":"google",
           "createdAt":FieldValue.serverTimestamp(),
         });
       }
     }
     return userCredential;
   }
   catch (e){
     logger.e(e);
     rethrow;
   }
 }

 static Future<void> signOut() async{
   try{
     await signIn.signOut();
     await auth.signOut();
   }catch (e){
     logger.e(e);
     throw e;
   }
 }

 static User? getCurrentUser(){
   return auth.currentUser;
 }
}