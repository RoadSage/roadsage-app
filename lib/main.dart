import 'package:flutter/material.dart';
import 'package:roadsage/screens/display.dart';
import 'package:roadsage/screens/faq.dart';
import 'package:roadsage/screens/preferences.dart';
import 'package:roadsage/screens/submit_question.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:tuple/tuple.dart';

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
  runApp(const RoadSageApp());
}

AuthClass authClass = AuthClass();

class RoadSageApp extends StatefulWidget {
  const RoadSageApp({Key? key}) : super(key: key);

  @override
  _RoadSageApp createState() => _RoadSageApp();
}

class _RoadSageApp extends State<RoadSageApp> {
  final SiriSuggestions siri = SiriSuggestions();

  _RoadSageApp() : super() {
    initSiriSuggestions();
  }

  String defaultPage = Routes.root;
  bool isLoggedIn = false;

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      isLoggedIn = true;
    }
    super.initState();
    // new Future.delayed(const Duration(seconds: 2));
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
    return MaterialApp(
      title: Constants.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        Routes.root: (context) =>
            const LoginScreen(title: Constants.loginPageTitle),
        Routes.home: (context) => const MainScreen(title: Constants.homePage),
        Routes.remote: (context) => const RemoteScreen(),
        Routes.display: (context) => const DisplayScreen(),
        Routes.faqSubmitQuestion: (context) => const SubmitQuestionScreen(),
        Routes.preferences: (context) => const PreferencesScreen(),
      },
      initialRoute: isLoggedIn ? Routes.home : Routes.root,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  int _selectedIndex = 0;

  // Tuple2(<Screen widget>, <App bar title>)
  static const _bottomNavItems = [
    Tuple2(FAQScreen(), Constants.help),
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
    AppBar appBar = AppBar(
      title: Text(_bottomNavItems.elementAt(_selectedIndex).item2),
      titleTextStyle: const TextStyle(fontSize: 32, shadows: [
        Shadow(color: Colors.black, blurRadius: 3, offset: Offset(0.6, 0.6)),
      ]),
      titleSpacing: 20,
      backgroundColor: RoadSageColours.lightGrey,
      toolbarHeight: 75,
      elevation: 0,
      centerTitle: false,
      actions: [
        Padding(
            padding: const EdgeInsets.only(top: 18, bottom: 22, right: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(RoadSageColours.lightBlue),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
              child: const Text(Constants.connected),
              onPressed: () {},
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
      type: BottomNavigationBarType.fixed,
      selectedItemColor: RoadSageColours.lightBlue,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: _onBottomNavItemTapped,
    );

    // Tuple2(<Item name>, <onClick>)
    final drawerItems = [
      Tuple2(RoadSageStrings.userProfile, () {
        Navigator.pop(context);
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
        Navigator.pushNamed(context, Routes.preferences);
      }),
    ];

    final Drawer drawer = Drawer(
        backgroundColor: RoadSageColours.lightGrey,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 150),
          itemCount: drawerItems.length + 1,
          itemBuilder: (context, index) {
            if (index == drawerItems.length) {
              return Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(RoadSageColours.grey),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  child: const Text(
                    RoadSageStrings.signOut,
                    style: TextStyle(fontSize: 14),
                  ),
                  onPressed: () => authClass.signOut(context: context),
                ),
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
        backgroundColor: RoadSageColours.lightGrey,
        bottomNavigationBar: bottomNavBar,
        endDrawer: drawer);
  }
}
