import 'package:flutter/material.dart';
import 'package:roadsage/constants.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: const Text(RoadSageStrings.preferences),
      titleTextStyle: const TextStyle(fontSize: 28, color: Colors.black),
      titleSpacing: 20,
      toolbarHeight: 75,
      elevation: 0,
      centerTitle: false,
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: RoadSageColours.lightGrey,
      body: Center(
          child: SettingsList(
        contentPadding: const EdgeInsets.all(16),
        sections: [
          SettingsSection(
            title: 'General',
            tiles: [
              SettingsTile(
                title: 'Language',
                subtitle: 'English',
              ),
              SettingsTile(
                title: 'Colour theme',
                subtitle: 'System Theme',
              ),
              SettingsTile(
                title: 'Time zone',
                subtitle: 'GMT (London)',
              ),
              SettingsTile(
                title: 'Temperature unit',
                subtitle: 'Celsius',
              ),
              SettingsTile(
                title: 'Distance unit',
                subtitle: 'Kilometers',
              )
            ],
          ),
          SettingsSection(
            title: 'About App',
            tiles: [
              SettingsTile(
                title: 'App version',
                subtitle: '0.3.0',
              )
            ],
          ),
          SettingsSection(
            title: 'About RoadSage',
            tiles: [
              SettingsTile(
                title: 'Product info',
                subtitle: 'RoadSage for cars',
              )
            ],
          )
        ],
      )),
    );
  }
}
