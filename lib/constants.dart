import 'package:flutter/material.dart';

/// Routes identify main destinations in the app
class Routes {
  static const String root = "/";
  static const String home = "/home";
  static const String welcome = "/welcome";
  static const String preferences = "/preferences";
  static const String remote = "/devices/remote";
  static const String display = "/devices/display";
  static const String faq = "/faq";
  static const String profile = "/profile";
  static const String faqSubmitQuestion = "/faq/submit_question";
}

/// Constants identify addresses, keys, filenames etc.
class Constants {
  static const String siriSuggestionKey = "key";
  static const String androidMethodChannel = "io.unitic.roadsage/google_assistant";
  static const String getAssistantMethod = "getAssistantQuery";
  static const String webServerAddress = "192.168.1.103:8000";

  static const String recentsDbFile = 'recents.db';
  static const String recentsTableName = 'recentcommands';

  static const String apiCommandId = 'id';
  static const String apiCommandInvocationMethod = 'invocation_method';
  static const String apiCommandCommand = 'command';
  static const String apiCommandTimestamp = 'timestamp';

  static const String phraseType = "phraseType";

  static const String prefsLocale = "sharedprefs.selected.locale";
  static const String prefsTheme = "sharedprefs.selected.theme";
  static const String prefsLoggedIn = "sharedprefs.logged_in";
  static const String prefsFirstLaunch = "sharedprefs.first_launch";
}

/// These are the String constannts used for internationalization.
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
  static const String login = "login_page.login";
  static const String password = "login_page.password";
  static const String signUp = "login_page.signUp";
  static const String loginSignUpUsing = "login_page.loginSignUpUsing";
  static const String mobile = "login_page.mobile";
  static const String email = "login_page.email";
  static const String enter6DigitCode = "login_page.enter6DigitCode";
  static const String checkYourEmailInbox = "login_page.checkYourEmailInbox";
  static const String checkYourMessages = "login_page.checkYourMessages";
  static const String resendCode = "login_page.resendCode";
  static const String emailAddress = "login_page.emailAddress";
  static const String byContinuing = "login_page.byContinuing";
  static const String phoneNumber = "login_page.phoneNumber";
  static const String sendCode = "login_page.sendCode";
  static const String firstName = "login_page.firstName";
  static const String lastName = "login_page.lastName";
  static const String dateOfBirth = "login_page.dateOfBirth";

  static const String welcomeToRoadSage = "welcome_page.welcome";
  static const String welcomeDescription1 = "welcome_page.description1";
  static const String welcomeDescription2 = "welcome_page.description2";
  static const String welcomeDescription3 = "welcome_page.description3";

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

  static const String connected = 'Connected';
  static const String scanning = 'Scanning....';
  static const String disconnected = 'Disconnected';

  static const String formName = 'form_strings.formName';
  static const String formFirstName = 'form_strings.formFirstName';
  static const String formLastName = 'form_strings.formLastName';
  static const String formFirstNameExample =
      'form_strings.formFirstNameExample';
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
  static const String thanksRoadsagePhrase =
      "control_strings.thanksRoadsagePhrase";

  static const String cheersRoadsage = "control_strings.cheersRoadsage";
  static const String cheersRoadsageDesc = "control_strings.cheersRoadsageDesc";
  static const String cheersRoadsagePhrase =
      "control_strings.cheersRoadsagePhrase";

  static const String beamRoadsage = "control_strings.beamRoadsage";
  static const String beamRoadsageDesc = "control_strings.beamRoadsageDesc";
  static const String beamRoadsagePhrase = "control_strings.beamRoadsagePhrase";

  static const String trySaying = "control_strings.trySaying";

  static const String helpAndFeedback = "control_strings.helpAndFeedback";
  static const String helpAndFeedbackDesc =
      "control_strings.helpAndFeedbackDesc";
  static const String feedbackHint = "control_strings.feedbackHint";
  static const String giveFeedback = "control_strings.giveFeedback";

  static const String googleAssistant = "recents_screen.google_assistant";
  static const String siri = "recents_screen.siri";
  static const String asd = "recents_screen.asd";
  static const String mountainSafe = "recents_screen.mountain_safe";
  static const String communication = "recents_screen.communication";
  static const String checkPreview = "recents_screen.check_your_previous";
  static const String homeScreenButton = "recents_screen.home_screen_button";

  static const String voiceCommandsPrefix = "voice_commands";

  static const String androidAssistantPhrase =
      "voice_commands.android_assistant_phrase";
  static const String iosAssistantPhrase =
      "voice_commands.ios_assistant_phrase";

  static const List<String> voiceCommands = <String>[
    "voice_commands.CHEERS",
    "voice_commands.THANK_YOU",
    "voice_commands.TURN_OFF_HIGH_BEAM",
  ];

  static const String permissionsFailed = "permissions.not_granted";

  static const String prefsLang = "prefs.language.lang";
  static const String prefsLangName = "prefs.language.name";
  static const String prefsColor = "prefs.color";
  static const String prefsTz = "prefs.time_zone";
  static const String prefsTemp = "prefs.temp";
  static const String prefsDist = "prefs.dist";
  static const String prefsClearRecents = "prefs.clear_recents";
  static const String prefsAbout = "prefs.about_app";
  static const String prefsVersion = "prefs.version";
  static const String prefsAboutRoadSage = "prefs.about_roadsage";
  static const String prefsProdInfo = "prefs.prod_info";
  static const String prefsProdInfoSub = "prefs.prod_info_sub";
  static const String prefsThemeSelect = "prefs.theme.select";
  static const String prefsThemeSystem = "prefs.theme.system";
  static const String prefsThemeLight = "prefs.theme.light";
  static const String prefsThemeDark = "prefs.theme.dark";
  static const String prefsLangSelect = "prefs.language.select_prompt";
  static const String prefsLangNameEn = "prefs.language.name.en";
  static const String prefsLangNameFr = "prefs.language.name.fr";
  static const String prefsLangEn = "en";
  static const String prefsLangFr = "fr";
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
