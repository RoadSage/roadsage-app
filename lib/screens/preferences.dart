import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadsage/constants.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:roadsage/state/models.dart';

class PreferencesScreen extends ConsumerStatefulWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends ConsumerState<PreferencesScreen> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: const Text(RoadSageStrings.preferences),
      titleTextStyle: const TextStyle(fontSize: 28, color: Colors.black),
      titleSpacing: 20,
      backgroundColor: RoadSageColours.lightGrey,
      toolbarHeight: 75,
      elevation: 0,
      centerTitle: false,
    );

    final roadSageModel = ref.watch(roadSageModelProvider);

    return Scaffold(
      appBar: appBar,
      backgroundColor: RoadSageColours.lightGrey,
      body: Center(
          child: SettingsList(
        contentPadding: const EdgeInsets.all(16),
        backgroundColor: RoadSageColours.lightGrey,
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
              ),
              SettingsTile(
                title: 'Login status',
                subtitle: roadSageModel.loggedIn ? "Logged in" : "Logged out",
                onPressed: (BuildContext context) => ref
                    .read(roadSageModelProvider.notifier)
                    .switchLoggedIn(!roadSageModel.loggedIn),
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
