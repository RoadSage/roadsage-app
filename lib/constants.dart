import 'package:flutter/material.dart';

class Routes {
  static const String root = "/";
  static const String home = "/home";
  static const String permission = "/permission";
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

  static const String prefsLocale = "sharedprefs.selected.locale";
  static const String prefsTheme = "sharedprefs.selected.theme";
}

class RoadSageStrings {
  static const String help = "app_bar.titles.help_and_feedback";
  static const String devices = "app_bar.titles.devices";
  static const String home = "app_bar.titles.home";
  static const String recents = "app_bar.titles.recents";

  static const String title = "RoadSage";
  static const String homePage = "Home Page";

  static const String loginPageTitle = "login_page.title";
  static const String tncAgreement = "login_page.tncAgreement";
  static const String byUnitic = "login_page.byUnitic";
  static const String troubleSigning = "login_page.troubleSigning";

  static const String signInWithGoogle = 'Sign in with Google';

  static const String userProfile = 'menu_titles.userProfile';
  static const String activity = 'menu_titles.activity';
  static const String buyRoadSage = 'menu_titles.buyRoadSage';
  static const String referAFriend = 'menu_titles.referAFriend';
  static const String preferences = 'menu_titles.preferences';
  static const String signOut = 'menu_titles.signOut';
  static const String faqs = 'menu_titles.faqs';
  static const String rateUs = 'menu_titles.rateUs';
  static const String contactUs = 'menu_titles.contactUs';

  static const String connected = 'connected';
  static const String disconnected = 'disconnected';

  static const String formName = 'form_strings.formName';
  static const String formFirstName = 'form_strings.formFirstName';
  static const String formLastName = 'form_strings.formLastName';
  static const String formFirstNameExample = 'form_strings.formFirstNameExample';
  static const String formLastNameExample = 'form_strings.formLastNameExample';
  static const String formEmail = 'form_strings.formEmail';
  static const String formEmailExample = 'form_strings.formEmailExample';
  static const String formPhone = 'form_strings.formPhone';
  static const String formPhoneExample = 'form_strings.formPhoneExample';
  static const String formSubmit = "form_strings.formSubmit";

  static const String remote = 'device_list.remote';
  static const String display = 'device_list.display';

  static const String status = 'device_info.status';
  static const String batteryLevel = 'device_info.batteryLevel';
  static const String brightnessLevel = 'device_info.brightnessLevel';
  static const String adaptiveBrightness = 'device_info.adaptiveBrightness';
  static const String sensor = 'device_info.sensor';
  static const String stoppingDistance = 'device_info.stoppingDistance';

  static const String openRoadsage = "control_strings.open_roadsage";
  static const String openRoadsageDesc = "control_strings.openRoadsageDesc";
  static const String launchRoadsage = "control_strings.launchRoadsage";
  static const String startRoadsage = "control_strings.startRoadsage";

  static const String thanksRoadsage = "control_strings.thanksRoadsage";
  static const String thanksRoadsageDesc = "control_strings.thanksRoadsageDesc";
  static const String thanksRoadsagePhrase = "control_strings.thanksRoadsagePhrase";

  static const String cheersRoadsage = "control_strings.cheersRoadsage";
  static const String cheersRoadsageDesc = "control_strings.cheersRoadsageDesc";
  static const String cheersRoadsagePhrase = "control_strings.cheersRoadsagePhrase";

  static const String beamRoadsage = "control_strings.beamRoadsage";
  static const String beamRoadsageDesc = "control_strings.beamRoadsageDesc";
  static const String beamRoadsagePhrase = "control_strings.beamRoadsagePhrase";

  static const String trySaying = "control_strings.trySaying";

  static const String helpAndFeedback = "control_strings.helpAndFeedback";
  static const String helpAndFeedbackDesc = "control_strings.helpAndFeedbackDesc";
  static const String feedbackHint = "control_strings.feedbackHint";
  static const String giveFeedback = "control_strings.giveFeedback";

  static const List<String> homeAndroidTrySayingEntries = <String>[
    "android_try_saying.1",
    "android_try_saying.2",
    "android_try_saying.3",
    "android_try_saying.4",
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
