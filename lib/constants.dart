import 'package:flutter/material.dart';

class Routes {
  static const String root = "/";
  static const String home = "/home";
  static const String faqSubmitQuestion = "/faq/submit_question";
}

class Constants {
  static const String title = "RoadSage";
  static const String loginPageTitle = "RoadSage Home Page";
  static const String homePage = "Home Page";
  static const String tncAgreement =
      "By clicking Login, you agree to our terms and conditions. Learn how we process your data in our ...";
  static const String byUnitic = "By Unitic";
  static const String troubleSigning = "Trouble Signing in?";

  static const String connected = "Connected";
  static const String help = "Help";
  static const String device = "Device";
  static const String home = "Home";
  static const String recents = "Recents";

  static const String siriSuggestionKey = "key";
}

// TODO: move some of the strings from Constants here
class RoadSageStrings {
  static const String signInWithGoogle = 'Sign in with Google';

  static const String userProfile = 'User Profile';
  static const String activity = 'Activity';
  static const String buyRoadSage = 'Buy RoadSage';
  static const String referAFriend = 'Refer a Friend';
  static const String appPreferences = 'App Preferences';
  static const String signOut = 'Sign Out';

  static const String openRoadsage = "Open_Roadsage";
  static const String openRoadsageDesc = "Opens the application";
  static const String launchRoadsage = "Launch Roadsage";
  static const String startRoadsage = "Start Roadsage";

  static const String thanksRoadsage = "Thanks_Roadsage";
  static const String thanksRoadsageDesc =
      "Says thank you to the car behind you";
  static const String thanksRoadsagePhrase = "Say Thank you on Roadsage";

  static const String cheersRoadsage = "Cheers_Roadsage";
  static const String cheersRoadsageDesc = "Says cheers to the car behind you";
  static const String cheersRoadsagePhrase = "Say Cheers on Roadsage";

  static const String beamRoadsage = "Beam_Roadsage";
  static const String beamRoadsageDesc =
      "Asks car behind you to turn off high beam";
  static const String beamRoadsagePhrase = "Say turn off high beam on Roadsage";

  static const String trySaying = "Try Saying";

  static const List<String> homeAndroidTrySayingEntries = <String>[
    "Hey Google, Say Thank you on RoadSage",
    "Hey Google, Say Cheers on RoadSage",
    "Hey Google, Say Turn off High Beam on RoadSage",
    "Hey Google, Say Cheers on RoadSage",
  ];
}

class RoadSageIcons {
  static const String googleIcon = 'assets/icons/google.png';
}

class RoadSageColours {
  static const Color lightBlue = Color(0xFF0AC0FF);
  static const Color lightGrey = Color(0xFFDCDCDC);
  static const Color grey = Color(0xFFC4C4C4);
}
