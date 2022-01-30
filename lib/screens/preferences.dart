import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadsage/constants.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:roadsage/state/models.dart';
import 'package:roadsage/utils.dart';

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
      titleSpacing: 20,
      toolbarHeight: 75,
      elevation: 0,
      centerTitle: false,
    );

    final roadSageModel = ref.watch(roadSageModelProvider);

    return Scaffold(
      appBar: appBar,
      body: Center(
          child: SettingsList(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                subtitle: roadSageModel.themeMode
                    .toString()
                    .substring(10)
                    .capitalize(),
                onPressed: (BuildContext context) async {
                  var result = await _chooseColourTheme();
                  if (result != null) {
                    ref
                        .watch(roadSageModelProvider.notifier)
                        .switchThemeMode(result);
                  }
                },
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

  Future<ThemeMode?> _chooseColourTheme() async {
    return showDialog<ThemeMode>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select colour theme'),
            contentPadding: const EdgeInsets.all(20),
            children: [
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, ThemeMode.system),
                child: const Text('System'),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, ThemeMode.light),
                child: const Text('Light'),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, ThemeMode.dark),
                child: const Text('Dark'),
              )
            ],
          );
        });
  }
}
