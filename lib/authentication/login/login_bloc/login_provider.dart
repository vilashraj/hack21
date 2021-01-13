import 'package:Hackathon/authentication/login/login_bloc/login_event.dart';
import 'package:Hackathon/utils/shared_pref_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
///
/// Meditab Software Inc. CONFIDENTIAL
/// __________________
/// 
///  [2018] Meditab Software Inc.
///  All Rights Reserved.
/// 
/// NOTICE:  All information contained herein is, and remains
/// the property of Meditab Software Inc. and its suppliers,
/// if any.  The intellectual and technical concepts contained
/// herein are proprietary to Meditab Software Incorporated
/// and its suppliers and may be covered by U.S. and Foreign Patents,
/// patents in process, and are protected by trade secret or copyright law.
/// Dissemination of this information or reproduction of this material
/// is strictly forbidden unless prior written permission is obtained
/// from Meditab Software Incorporated.

/// <h1>login_provider</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/12/21 2:46 pm
/// 

class LoginProvider {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<User> login({@required String userName, @required String password})async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userName,
          password: password
      );
      SharedPrefUtils sharedPrefUtils = SharedPrefUtils();
      await sharedPrefUtils.setValue(key: SharedPrefKey.userId, value: userCredential.user.uid);
      await sharedPrefUtils.setValue(key: SharedPrefKey.email, value: userName);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw('Wrong password provided for that user.');
      }
    }
  return null;
  }

  Future<User> socialLogin({@required SocialLogin socialLogin})async{
    switch(socialLogin){
      case SocialLogin.google:
        return await signInWithGoogle();
      default:
        return null;
    }
  }

  Future<User> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential =  await FirebaseAuth.instance.signInWithCredential(credential);
    SharedPrefUtils sharedPrefUtils = SharedPrefUtils();
    await sharedPrefUtils.setValue(key: SharedPrefKey.userId, value: userCredential.user.uid);
    await sharedPrefUtils.setValue(key: SharedPrefKey.email, value: userCredential.user.email);

    return userCredential.user;
  }
}