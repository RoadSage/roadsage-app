import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'siri_suggestions.dart';

import 'package:tuple/tuple.dart';

import 'login.dart';
import 'constants.dart';

import 'screens/help.dart';
import 'screens/device.dart';
import 'screens/home.dart';
import 'screens/recents.dart';

void main() {
  runApp(RoadSageApp());
}

class RoadSageApp extends StatelessWidget {
  SiriSuggestions siri = SiriSuggestions();
  RoadSageApp({Key? key}) : super(key: key) {
    initSiriSuggestions();
  }

  void initSiriSuggestions() async {
    print("Initializing siri suggestions");
    WidgetsFlutterBinding.ensureInitialized();
    siri.configure(onLaunch: (Map<String, dynamic> message) async {
      print("called by ${message['key']} suggestion.");

      print("Siri Suggestion called to perform ${message['key']}");

      switch (message["key"]) {
        case "Open_Roadsage":
          // Launch main page
          break;
        case "Thanks_Roadsage":
          // say thank you
          break;
        case "Cheers_Roadsage":
          // say cheers
          break;
        case "Beam_RoadSage":
          // open beam
          break;
        default:
          // suggestion key wasn't added
          break;
      }
    });

    for (String phrase in ["Launch Roadsage", "Start Roadsage"]) {
      siri.addEzSuggestion("Open_Roadsage", "Opens the application", phrase);
    }

    siri.addEzSuggestion("Thanks_Roadsage",
        "Says thank you to the car behind you", "Say Thank you on Roadsage");
    siri.addEzSuggestion("Cheers_Roadsage", "Says cheers to the car begind you",
        "Say Cheers on Roadsage");
    siri.addEzSuggestion(
        "Beam_RoadSage",
        "Asks car behind you to turn off high beam",
        "Say turn off high beam on Roadsage");
    print("Initialized Siri Successfully!");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
            headline3: GoogleFonts.mukta(
              fontSize: 48,
              color: Colors.white,
              shadows: <Shadow>[
                const Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                const Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 8.0,
                  color: Color.fromARGB(125, 0, 0, 255),
                ),
              ],
            ),
            subtitle1: GoogleFonts.mukta(
                fontSize: 18,
                color: Colors.white,
                shadows: <Shadow>[
                  const Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  const Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 8.0,
                    color: Color.fromARGB(125, 0, 0, 255),
                  ),
                ])),
      ),
      initialRoute: Routes.root,
      routes: {
        Routes.root: (context) =>
            const LoginScreen(title: Constants.loginPageTitle),
        Routes.home: (context) => const MainScreen(title: Constants.homePage),
      },
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

  static const List<Widget> _bottomNavScreens = <Widget>[
    HelpScreen(),
    DeviceScreen(),
    HomeScreen(),
    RecentsScreen(),
  ];

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _drawerItems = [
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
      Tuple2(RoadSageStrings.appPreferences, () {
        Navigator.pop(context);
      }),
    ];

    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text(
          Constants.title,
        ),
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
      ),
      body: _bottomNavScreens.elementAt(_selectedIndex),
      backgroundColor: RoadSageColours.lightGrey,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: Constants.help,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_android_outlined),
            label: Constants.device,
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
      ),
      endDrawer: Drawer(
        backgroundColor: RoadSageColours.lightGrey,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 150),
          itemCount: _drawerItems.length + 1,
          itemBuilder: (context, index) {
            if (index == _drawerItems.length) {
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
                  onPressed: () {},
                ),
              );
            }

            return Column(
              children: [
                ListTile(
                    title: Text(
                      _drawerItems[index].item1,
                      style: const TextStyle(fontSize: 16),
                    ),
                    onTap: _drawerItems[index].item2),
                const Divider(
                  color: Colors.black,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
