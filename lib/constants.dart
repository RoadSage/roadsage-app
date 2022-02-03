import 'package:flutter/material.dart';

class Routes {
  static const String root = "/";
  static const String home = "/home";
  static const String preferences = "/preferences";
  static const String remote = "/devices/remote";
  static const String display = "/devices/display";
  static const String faq = "/faq";
  static const String profile = "/profile";
  static const String faqSubmitQuestion = "/faq/submit_question";
}

class Constants {
  static const String siriSuggestionKey = "key";
  static const String androidMethodChannel =
      "io.unitic.roadsage/google_assistant";
  static const String getAssistantMethod = "getAssistantQuery";
}

class RoadSageStrings {
  static const String help = "app_bar.titles.help_and_feedback";
  static const String devices = "app_bar.titles.devices";
  static const String home = "app_bar.titles.home";
  static const String recents = "app_bar.titles.recents";

  static const String title = "RoadSage";

  static const String loginPageTitle = "RoadSage Home Page";
  static const String homePage = "Home Page";
  static const String tncAgreement =
      "By clicking Login, you agree to our terms and conditions. Learn how we process your data in our ...";
  static const String byUnitic = "By Unitic";
  static const String troubleSigning = "Trouble Signing in?";

  static const String signInWithGoogle = 'Sign in with Google';
  static const String userProfile = 'User Profile';
  static const String activity = 'Activity';
  static const String buyRoadSage = 'Buy RoadSage';
  static const String referAFriend = 'Refer a Friend';
  static const String preferences = 'prefs.title';
  static const String signOut = 'Sign Out';
  static const String faqs = 'FAQs';
  static const String rateUs = 'Rate Us';
  static const String contactUs = 'Contact Us';

  static const String connected = 'Connected';
  static const String disconnected = 'Disconnected';

  static const String formName = 'Name';
  static const String formFirstName = 'First Name';
  static const String formLastName = 'Last Name';
  static const String formFirstNameExample = 'Fatma';
  static const String formLastNameExample = 'Alsayegh';
  static const String formEmail = 'Email';
  static const String formEmailExample = 'example@mail.com';
  static const String formPhone = 'Phone';
  static const String formPhoneExample = 'phone';
  static const String formSubmit = "Submit";

  static const String remote = 'Remote';
  static const String display = 'Display';

  static const String status = 'Status';
  static const String batteryLevel = 'Battery level';
  static const String brightnessLevel = 'Brightness level';
  static const String adaptiveBrightness = 'Adaptive Brightness';
  static const String sensor = 'Sensor';
  static const String stoppingDistance = 'Stopping distance';

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

  static const String helpAndFeedback = "Help & Feedback";
  static const String helpAndFeedbackDesc =
      "Your  feedback is important to help us improve our products.";
  static const String feedbackHint = "Write your feedback here";
  static const String giveFeedback = "Give Feedback";

  static const List<String> homeAndroidTrySayingEntries = <String>[
    "Hey Google, Say Thank you on RoadSage",
    "Hey Google, Say Cheers on RoadSage",
    "Hey Google, Say Turn off High Beam on RoadSage",
    "Hey Google, Say Cheers on RoadSage",
  ];

  static const List<String> homeIOSTrySayingEntries = <String>[
    "Hey Siri, Say Thank you on RoadSage",
    "Hey Siri, Say Cheers on RoadSage",
    "Hey Siri, Say Turn off High Beam on RoadSage",
    "Hey Siri, Say Cheers on RoadSage",
  ];
}

class RoadSageIcons {
  static const String googleIcon = 'assets/icons/google.png';
}

class RoadSageColours {
  static const Color lightBlue = Color(0xFF0AC0FF);
  static const Color lightGrey = Color(0xFFDCDCDC);
  static const Color darkGrey = Color(0xFF303030);
  static const Color grey = Color(0xFFC4C4C4);
  static const Color darkBg = Color(0xFF121212);
}
