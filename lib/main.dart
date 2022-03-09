import 'package:flutter/material.dart';

import 'package:roadsage/screens/display.dart';
import 'package:roadsage/screens/faq.dart';
import 'package:roadsage/screens/help.dart';
import 'package:roadsage/screens/permission.dart';
import 'package:roadsage/screens/preferences.dart';
import 'package:roadsage/screens/profile.dart';
import 'package:roadsage/screens/submit_question.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roadsage/state/models.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'package:roadsage/authentication/auth_services.dart';
import 'constants.dart';
import 'siri_suggestions.dart';

import 'screens/login.dart';
import 'screens/devices.dart';
import 'screens/home.dart';
import 'screens/recents.dart';
import 'screens/remote.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en_GB',
      supportedLocales: ['en_GB', 'en_US', 'fr'],
      preferences: TranslatePreferences());

  runApp(LocalizedApp(delegate, const ProviderScope(child: RoadSageApp())));
}

AuthClass authClass = AuthClass();

class RoadSageApp extends ConsumerStatefulWidget {
  const RoadSageApp({Key? key}) : super(key: key);

  @override
  _RoadSageApp createState() => _RoadSageApp();
}

class _RoadSageApp extends ConsumerState<RoadSageApp> {
  final SiriSuggestions siri = SiriSuggestions();

  _RoadSageApp() : super() {
    initSiriSuggestions();
  }

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      ref.read(roadSageModelProvider.notifier).switchLoggedIn(true);
    }
    super.initState();
  }

  @override
  void dispose() {
    // _intentStream?.cancel();
    super.dispose();
  }

  void initSiriSuggestions() async {
    //print("Initializing siri suggestions");
    WidgetsFlutterBinding.ensureInitialized();
    siri.configure(onLaunch: (Map<String, dynamic> message) async {
      //print("Siri Suggestion called to perform ${message['key']}");

      switch (message[Constants.siriSuggestionKey]) {
        case RoadSageStrings.openRoadsage:
          // Launch main page
          break;
        case RoadSageStrings.thanksRoadsage:
          // say thank you
          break;
        case RoadSageStrings.cheersRoadsage:
          // say cheers
          break;
        case RoadSageStrings.beamRoadsage:
          // open beam
          break;
        default:
          // suggestion key wasn't added
          break;
      }
    });

    for (String phrase in [
      translate(RoadSageStrings.launchRoadsage),
      translate(RoadSageStrings.startRoadsage)
    ]) {
      siri.addEzSuggestion(translate(RoadSageStrings.openRoadsage),
          translate(RoadSageStrings.openRoadsageDesc), phrase);
    }

    siri.addEzSuggestion(
        translate(RoadSageStrings.thanksRoadsage),
        translate(RoadSageStrings.thanksRoadsageDesc),
        translate(RoadSageStrings.thanksRoadsagePhrase));

    siri.addEzSuggestion(
        translate(RoadSageStrings.cheersRoadsage),
        translate(RoadSageStrings.cheersRoadsageDesc),
        translate(RoadSageStrings.cheersRoadsagePhrase));

    siri.addEzSuggestion(
        translate(RoadSageStrings.beamRoadsage),
        translate(RoadSageStrings.beamRoadsageDesc),
        translate(RoadSageStrings.beamRoadsagePhrase));
    //print("Initialized Siri Successfully!");
  }

  @override
  Widget build(BuildContext context) {
    final roadSageModel = ref.watch(roadSageModelProvider);

    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        title: translate(RoadSageStrings.title),
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: RoadSageColours.lightGrey,
          primaryColor: RoadSageColours.lightGrey,
          primaryColorLight: Colors.white,
          primaryColorDark: Colors.grey.shade700,
          colorScheme: const ColorScheme.light()
              .copyWith(secondary: Colors.lightBlue, primary: Colors.lightBlue),
          textTheme: ThemeData.light().textTheme.copyWith(
                button: const TextStyle(color: Colors.black),
              ),
          bottomNavigationBarTheme:
              const BottomNavigationBarThemeData(backgroundColor: Colors.white),
          appBarTheme: const AppBarTheme(
              backgroundColor: RoadSageColours.lightGrey,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 28)),
          drawerTheme:
              const DrawerThemeData(backgroundColor: RoadSageColours.lightGrey),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(RoadSageColours.lightBlue)),
          ),
          dialogBackgroundColor: RoadSageColours.lightGrey,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: RoadSageColours.darkBg,
          primaryColor: RoadSageColours.darkGrey,
          primaryColorLight: RoadSageColours.darkGrey,
          colorScheme: const ColorScheme.dark()
              .copyWith(secondary: Colors.lightBlue, primary: Colors.lightBlue),
          textTheme: ThemeData.dark().textTheme.copyWith(
                button: const TextStyle(color: Colors.white),
              ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: RoadSageColours.darkGrey),
          appBarTheme: const AppBarTheme(
              backgroundColor: RoadSageColours.darkGrey,
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 28)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all(RoadSageColours.lightBlue))),
          dialogBackgroundColor: RoadSageColours.darkBg,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        themeMode: roadSageModel.themeMode,
        routes: {
          Routes.root: (context) => const LoginScreen(),
          Routes.home: (context) => const MainScreen(),
          Routes.remote: (context) => const RemoteScreen(),
          Routes.display: (context) => const DisplayScreen(),
          Routes.faq: (context) => const FAQScreen(),
          Routes.faqSubmitQuestion: (context) => const SubmitQuestionScreen(),
          Routes.preferences: (context) => const PreferencesScreen(),
          Routes.profile: (context) => const ProfileScreen(),
          Routes.permission: (context) => const PermissionScreen(),
        },
        initialRoute: roadSageModel.loggedIn ? Routes.home : Routes.root,
        onGenerateRoute: (settings) {
          String? path = settings.name;
          if (path != null && path.contains("phraseType")) {
            String query = path.substring(path.indexOf("phraseType=") + 11);
            Fluttertoast.showToast(msg: "Query is $query");
            return MaterialPageRoute(builder: (_) => const MainScreen());
          }
          return null;
        },
        onUnknownRoute: (_) {
          return MaterialPageRoute(builder: (_) => const MainScreen());
        },
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
      ),
    );
  }
}

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key, String? query}) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  // default - 2 - HomeScreen
  int _selectedIndex = 2;

  // Tuple2(<Screen widget>, <App bar title>)
  static final _bottomNavItems = [
    Tuple2(const HelpScreen(), translate(RoadSageStrings.help)),
    Tuple2(const DevicesScreen(), translate(RoadSageStrings.devices)),
    Tuple2(const HomeScreen(), translate(RoadSageStrings.home)),
    Tuple2(const RecentsScreen(), translate(RoadSageStrings.recents)),
  ];

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayModel = ref.watch(displayModelProvider);

    AppBar appBar = AppBar(
      title: Text(_bottomNavItems.elementAt(_selectedIndex).item2),
      titleTextStyle: const TextStyle(fontSize: 32, shadows: [
        Shadow(color: Colors.black, blurRadius: 3, offset: Offset(0.6, 0.6)),
      ]),
      titleSpacing: 20,
      backgroundColor: Colors.transparent,
      toolbarHeight: 75,
      elevation: 0,
      centerTitle: false,
      actions: [
        Padding(
            padding: const EdgeInsets.only(top: 18, bottom: 22, right: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              child: Text(displayModel.displayStatus
                  ? translate(RoadSageStrings.connected)
                  : translate(RoadSageStrings.disconnected)),
              onPressed: () => Navigator.pushNamed(context, Routes.display),
            )),
        IconButton(
          icon: const Icon(Icons.menu),
          iconSize: 36,
          color: RoadSageColours.lightBlue,
          // color: Colors.red,
          onPressed: () {
            _key.currentState!.openEndDrawer();
          },
        ),
      ],
    );

    final BottomNavigationBar bottomNavBar = BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: const Icon(Icons.help_outline),
          label: translate(RoadSageStrings.help),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.phone_android_outlined),
          label: translate(RoadSageStrings.devices),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          label: translate(RoadSageStrings.home),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.message_outlined),
          label: translate(RoadSageStrings.recents),
        ),
      ],
      currentIndex: _selectedIndex,
      iconSize: 26,
      selectedItemColor: RoadSageColours.lightBlue,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: _onBottomNavItemTapped,
    );

    // Tuple2(<Item name>, <onClick>)
    final drawerItems = [
      Tuple2(translate(RoadSageStrings.userProfile), () {
        Navigator.popAndPushNamed(context, Routes.profile);
      }),
      Tuple2(translate(RoadSageStrings.activity), () {
        Navigator.pop(context);
      }),
      Tuple2(translate(RoadSageStrings.buyRoadSage), () {
        Navigator.pop(context);
      }),
      Tuple2(translate(RoadSageStrings.referAFriend), () {
        Navigator.pop(context);
      }),
      Tuple2(translate(RoadSageStrings.preferences), () {
        Navigator.popAndPushNamed(context, Routes.preferences);
      }),
    ];

    final Drawer drawer = Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 150),
          itemCount: drawerItems.length + 1,
          itemBuilder: (context, index) {
            if (index == drawerItems.length) {
              return Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    child: Text(
                      translate(RoadSageStrings.signOut),
                      style: const TextStyle(fontSize: 14),
                    ),
                    onPressed: () {
                      ref
                          .read(roadSageModelProvider.notifier)
                          .switchLoggedIn(false);
                      authClass.signOut(context: context);
                    }),
              );
            }
            return Column(
              children: [
                ListTile(
                    title: Text(
                      translate(drawerItems[index].item1),
                      style: const TextStyle(fontSize: 16),
                    ),
                    onTap: drawerItems[index].item2),
                const Divider(
                  color: Colors.black,
                ),
              ],
            );
          },
        ));

    return Scaffold(
        key: _key,
        appBar: appBar,
        body: _bottomNavItems.elementAt(_selectedIndex).item1,
        bottomNavigationBar: bottomNavBar,
        endDrawer: drawer);
  }
}
