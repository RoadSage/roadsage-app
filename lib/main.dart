import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';
import 'constants.dart';

import 'screens/help.dart';
import 'screens/device.dart';
import 'screens/home.dart';
import 'screens/recents.dart';

void main() {
  runApp(const RoadSageApp());
}

class RoadSageApp extends StatelessWidget {
  const RoadSageApp({Key? key}) : super(key: key);

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
        child: ListView(
          children: [
            ListTile(
              title: const Text('item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
