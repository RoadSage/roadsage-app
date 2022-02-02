import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:roadsage/constants.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:roadsage/state/models.dart';
import 'package:roadsage/utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PreferencesScreen extends ConsumerStatefulWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends ConsumerState<PreferencesScreen> {
  String _appVersion = "";

  @override
  void initState() {
    initPlatformInfo();
    super.initState();
  }

  void initPlatformInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text(translate(RoadSageStrings.preferences)),
      titleSpacing: 20,
      backgroundColor: Colors.transparent,
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
                title: translate("prefs.language.lang"),
                subtitle: translate(
                    "prefs.language.name.${roadSageModel.languageCode}"),
                onPressed: (BuildContext context) async {
                  var result = await _chooseLanguage();
                  if (result != null) {
                    changeLocale(context, result);
                    ref
                        .read(roadSageModelProvider.notifier)
                        .switchLanguage(result);
                  }
                },
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
                subtitle: _appVersion,
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

  Future<String?> _chooseLanguage() async {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(translate('prefs.language.select_prompt')),
            contentPadding: const EdgeInsets.all(20),
            children: [
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, 'en'),
                child: Text(translate('prefs.language.name.en')),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, 'fr'),
                child: Text(translate('prefs.language.name.fr')),
              ),
            ],
          );
        });
  }
}
