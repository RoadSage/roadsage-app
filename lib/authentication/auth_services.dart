import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:roadsage/constants.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;

import 'package:roadsage/main.dart';
import 'package:roadsage/screens/login.dart';

/// Small class to do some handling of the data from facebook
class Resource {
  final Status status;
  Resource({required this.status});
}

enum Status { success, error, cancelled }

/// This is the main singleton class that will handle all signing up, in and out of various different services.
class AuthClass {
  static final AuthClass _instance = AuthClass._internal();

  factory AuthClass() {
    return _instance;
  }

  // Singleton constructor
  AuthClass._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final tokenStorage = const FlutterSecureStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    // 'https://www.googleapis.com/auth/contacts.readonly'
  ]);

  /// Issues a sign up HTTP request to the RoadSage API
  Future<bool> signUpAPI(
      {String? email, String? fullName, String? password}) async {
    var url = Uri.http(Constants.webServerAddress, "/signup");
    // TODO: returning informative errors from this would help

    Map data = {
      "email": email,
      "full_name": fullName,
      "disabled": "false",
      "admin": "false",
      "password": password,
    };

    http.Response? response;

    await http
        .post(url,
            headers: {HttpHeaders.contentTypeHeader: "application/json"},
            body: json.encode(data))
        .then((value) {
      response = value;
    }).onError((error, stackTrace) {
      response = null;
    });

    if (response == null) {
      return false;
    }

    if (response!.statusCode == 200) {
      return true;
    }
    // } else if (response!.statusCode == 409) {
    // return "User with this email is already registered!";
    // }

    return false;
  }

  /// Issues a sign in HTTP request to the RoadSage API
  /// Stores the returned authentication token on the device
  Future<bool> signInAPI(String email, String password) async {
    var url = Uri.http(Constants.webServerAddress, "/login");
    // TODO: returning informative errors from this would help

    http.Response? response;

    await http.post(url, headers: {
      HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"
    }, body: {
      'username': email,
      'password': password,
    }).then((value) {
      response = value;
    }).onError((error, stackTrace) {
      response = null;
    });

    if (response == null) {
      return false;
    }

    // Success, save the login token
    if (response!.statusCode == 200) {
      String? token = jsonDecode(response!.body)['access_token'];
      if (token == null) {
        return false;
      }

      tokenStorage.write(key: "api_token", value: token);
      return true;
    }

    return false;
  }

  /// Returns the stored authentication token for the RoadSage API
  Future<String?> getAuthenticationToken() async {
    return tokenStorage.read(key: 'api_token');
  }

  /// Handles the signing in via google services
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

        await tokenStorage.write(
            key: "token", value: userCredential.credential?.token.toString());
        await tokenStorage.write(
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

  /// Handles the signing in with apple
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

    await tokenStorage.write(
        key: "token", value: userCredential.credential?.token.toString());
    await tokenStorage.write(
        key: "userCredential", value: userCredential.toString());
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => const MainScreen()),
      (route) => false,
    );
  }

  /// Handles signing in via Facebook services
  Future<Resource?> signInWithFacebook(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login();
    try {
      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential facebookCredential =
              FacebookAuthProvider.credential(result.accessToken!.token);
          final userCredential =
              await _auth.signInWithCredential(facebookCredential);

          await tokenStorage.write(
              key: "token", value: userCredential.credential?.token.toString());
          await tokenStorage.write(
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

  /// Allows the users to sign up to a RoadSage Account, then logging them in
  /// and redirecting them to the home page.
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

  /// Signs the user in and redirects them to the home page
  Future signIn(BuildContext context,
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      await tokenStorage.write(
          key: "token", value: userCredential.credential?.token.toString());
      await tokenStorage.write(
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

  /// Sign the current user out of Google/Facebook/Email
  /// Return the user to the login page
  Future<void> signOut({required BuildContext context}) async {
    await _googleSignIn.signOut();
    await FacebookAuth.instance.logOut();
    await _auth.signOut();
    await tokenStorage.delete(key: "token");
    await tokenStorage.delete(key: "api_token");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (builder) => const LoginScreen()),
      (route) => false,
    );
  }

  /// Get the token value for the current user
  Future<String> getToken() async {
    return (await tokenStorage.read(key: "token")).toString();
  }
}
