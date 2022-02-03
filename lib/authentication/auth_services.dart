import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:roadsage/main.dart';
import 'package:roadsage/constants.dart';
import 'package:roadsage/screens/login.dart';

// Small class to do some handling of the data from facebook
class Resource {
  final Status status;
  Resource({required this.status});
}

enum Status { success, error, cancelled }

// This is the main class that will handle all signing up, in and out of vairous different services.
class AuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final tokenStoage = const FlutterSecureStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    // 'https://www.googleapis.com/auth/contacts.readonly'
  ]);

  // Handles the signing in via google services
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      GoogleSignInAccount? gSignInAccount = await _googleSignIn.signIn();

      if (gSignInAccount != null) {
        GoogleSignInAuthentication gSignInAuth =
            await gSignInAccount.authentication;
        AuthCredential credentials = GoogleAuthProvider.credential(
          idToken: gSignInAuth.idToken,
          accessToken: gSignInAuth.accessToken,
        );

        UserCredential userCredential =
            await _auth.signInWithCredential(credentials);

        await tokenStoage.write(
            key: "token", value: userCredential.credential?.token.toString());
        await tokenStoage.write(
            key: "userCredential", value: userCredential.toString());

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => const MainScreen()),
          (route) => false,
        );

        String? snackbarText = userCredential.user?.displayName;
        final snackbar = SnackBar(
            content: Text(snackbarText == null ? '' : snackbarText.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInWithApple(BuildContext context) async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    // TODO: SEE WHEN IT FAILS -- NEEED TESTING
    // if (credential.authorizationCode

    final userCredential = await _auth.signInWithCredential(OAuthCredential(
        providerId: "apple.com",
        signInMethod: "apple.com",
        accessToken: credential.authorizationCode));

    await tokenStoage.write(
        key: "token", value: userCredential.credential?.token.toString());
    await tokenStoage.write(
        key: "userCredential", value: userCredential.toString());
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => const MainScreen()),
      (route) => false,
    );
  }

  // Handles signing in via Facebook services
  Future<Resource?> signInWithFacebook(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login();
    try {
      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential facebookCredential =
              FacebookAuthProvider.credential(result.accessToken!.token);
          final userCredential =
              await _auth.signInWithCredential(facebookCredential);

          await tokenStoage.write(
              key: "token", value: userCredential.credential?.token.toString());
          await tokenStoage.write(
              key: "userCredential", value: userCredential.toString());

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => const MainScreen()),
            (route) => false,
          );

          return Resource(status: Status.success);

        case LoginStatus.cancelled:
          return Resource(status: Status.cancelled);

        case LoginStatus.failed:
          return Resource(status: Status.error);

        default:
          return null;
      }
    } on FirebaseAuthException {
      rethrow;
    }
  }

  // Allows the users to sign up to a RoadSage Account, then logging them in
  // and redirecting them to the home page
  Future signUp(BuildContext context,
      {required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // TODO Email validation

      return signIn(context, email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Signs the user in and redirects them to the home page
  Future signIn(BuildContext context,
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      await tokenStoage.write(
          key: "token", value: userCredential.credential?.token.toString());
      await tokenStoage.write(
          key: "userCredential", value: userCredential.toString());

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (builder) => const MainScreen()),
        (route) => false,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Sign the current user out of Google/Facebook/Email
  // Return the user to the login page
  Future<void> signOut({required BuildContext context}) async {
    await _googleSignIn.signOut();
    await FacebookAuth.instance.logOut();
    await _auth.signOut();
    await tokenStoage.delete(key: "token");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => const LoginScreen()),
      (route) => false,
    );
  }

  // Get the token value for the current user
  Future<String> getToken() async {
    return (await tokenStoage.read(key: "token")).toString();
  }
}
