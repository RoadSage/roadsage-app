import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:roadsage/screens/display.dart';
import 'package:roadsage/screens/faq.dart';
import 'package:roadsage/screens/help.dart';
import 'package:roadsage/screens/preferences.dart';
import 'package:roadsage/screens/profile.dart';
import 'package:roadsage/screens/submit_question.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lifecycle/lifecycle.dart';
import 'package:roadsage/state/models.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  runApp(const ProviderScope(child: RoadSageApp()));
}

AuthClass authClass = AuthClass();

class RoadSageApp extends ConsumerStatefulWidget {
  const RoadSageApp({Key? key}) : super(key: key);

  @override
  _RoadSageApp createState() => _RoadSageApp();
}

class _RoadSageApp extends ConsumerState<RoadSageApp>
    with LifecycleAware, LifecycleMixin {
  final SiriSuggestions siri = SiriSuggestions();

  _RoadSageApp() : super() {
    initSiriSuggestions();
  }

  String defaultPage = Routes.root;
  static const platform = MethodChannel(Constants.androidMethodChannel);
  String? _assistantQuery;

  // Get Google Assistant query from the Android platform
  Future<void> getAssistantQuery() async {
    var assistantQuery =
        await platform.invokeMethod(Constants.getAssistantMethod);
    if (assistantQuery != null) {
      setState(() {
        _assistantQuery = assistantQuery;
      });
    }
  }

  @override
  void onLifecycleEvent(LifecycleEvent event) async {
    // Push event is triggered when a Google Assistant request is received
    if (event == LifecycleEvent.push) {
      // Get the query from Android through the method channel
      await getAssistantQuery();
      // If a query was received, show a toast, log it and clear the field
      if (_assistantQuery != null) {
        debugPrint('Assistant query is $_assistantQuery');
        Fluttertoast.showToast(msg: "Query is $_assistantQuery");
        _assistantQuery = null;
      }
    }
  }

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      ref.read(roadSageModelProvider.notifier).switchLoggedIn(true);
    }
    super.initState();
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
      RoadSageStrings.launchRoadsage,
      RoadSageStrings.startRoadsage
    ]) {
      siri.addEzSuggestion(RoadSageStrings.openRoadsage,
          RoadSageStrings.openRoadsageDesc, phrase);
    }

    siri.addEzSuggestion(
        RoadSageStrings.thanksRoadsage,
        RoadSageStrings.thanksRoadsageDesc,
        RoadSageStrings.thanksRoadsagePhrase);

    siri.addEzSuggestion(
        RoadSageStrings.cheersRoadsage,
        RoadSageStrings.cheersRoadsageDesc,
        RoadSageStrings.cheersRoadsagePhrase);

    siri.addEzSuggestion(RoadSageStrings.beamRoadsage,
        RoadSageStrings.beamRoadsageDesc, RoadSageStrings.beamRoadsagePhrase);
    //print("Initialized Siri Successfully!");
  }

  @override
  Widget build(BuildContext context) {
    final roadSageModel = ref.watch(roadSageModelProvider);

    return MaterialApp(
      title: Constants.title,
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
                      MaterialStateProperty.all(RoadSageColours.lightBlue)))),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: RoadSageColours.darkGrey,
        primaryColorLight: Colors.black,
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
      ),
      themeMode: roadSageModel.themeMode,
      navigatorObservers: [defaultLifecycleObserver],
      routes: {
        Routes.root: (context) =>
            const LoginScreen(title: Constants.loginPageTitle),
        Routes.home: (context) => const MainScreen(title: Constants.homePage),
        Routes.remote: (context) => const RemoteScreen(),
        Routes.display: (context) => const DisplayScreen(),
        Routes.faq: (context) => const FAQScreen(),
        Routes.faqSubmitQuestion: (context) => const SubmitQuestionScreen(),
        Routes.preferences: (context) => const PreferencesScreen(),
        Routes.profile: (context) => const ProfileScreen(),
      },
      initialRoute: roadSageModel.loggedIn ? Routes.home : Routes.root,
    );
  }
}

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  // default - 2 - HomeScreen
  int _selectedIndex = 2;

  // Tuple2(<Screen widget>, <App bar title>)
  static const _bottomNavItems = [
    Tuple2(HelpScreen(), Constants.help),
    Tuple2(DevicesScreen(), Constants.devices),
    Tuple2(HomeScreen(), Constants.home),
    Tuple2(RecentsScreen(), Constants.recents),
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
                  ? RoadSageStrings.connected
                  : RoadSageStrings.disconnected),
              onPressed: () => Navigator.pushNamed(context, Routes.display),
            )),
        IconButton(
          icon: const Icon(Icons.menu),
          iconSize: 36,
          color: RoadSageColours.lightBlue,
          onPressed: () {
            _key.currentState!.openEndDrawer();
          },
        ),
      ],
    );

    final BottomNavigationBar bottomNavBar = BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.help_outline),
          label: Constants.help,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.phone_android_outlined),
          label: Constants.devices,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: Constants.home,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message_outlined),
          label: Constants.recents,
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
      Tuple2(RoadSageStrings.userProfile, () {
        Navigator.popAndPushNamed(context, Routes.profile);
      }),
      Tuple2(RoadSageStrings.activity, () {
        Navigator.pop(context);
      }),
      Tuple2(RoadSageStrings.buyRoadSage, () {
        Navigator.pop(context);
      }),
      Tuple2(RoadSageStrings.referAFriend, () {
        Navigator.pop(context);
      }),
      Tuple2(RoadSageStrings.preferences, () {
        Navigator.popAndPushNamed(context, Routes.preferences);
      }),
    ];

    final Drawer drawer = Drawer(
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
                child: const Text(
                  RoadSageStrings.signOut,
                  style: TextStyle(fontSize: 14),
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
                  drawerItems[index].item1,
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
