import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:roadsage/constants.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:roadsage/state/models.dart';
import 'package:roadsage/utils.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Screen showing app's preferences
class PreferencesScreen extends ConsumerStatefulWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends ConsumerState<PreferencesScreen> {
  String _appVersion = "";
  late SharedPreferences prefs;

  @override
  void initState() {
    initPlatformInfo();
    initSharedPreferences();
    super.initState();
  }

  // Shared preferences store the settings on device
  void initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Platform info lets us get device information
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
                title: translate(RoadSageStrings.prefsLang),
                subtitle: translate(
                    "${RoadSageStrings.prefsLangName}.${roadSageModel.languageCode}"),
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
                title: (translate(RoadSageStrings.prefsColor)),
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
                title: translate(RoadSageStrings.prefsTz),
                subtitle: "GMT (London)",
              ),
              SettingsTile(
                title: translate(RoadSageStrings.prefsTemp),
                subtitle: "Celsius",
              ),
              SettingsTile(
                title: translate(RoadSageStrings.prefsDist),
                subtitle: "Kilometers",
              ),
              SettingsTile(
                  title: translate(RoadSageStrings.prefsClearRecents),
                  onPressed: (BuildContext context) =>
                      ref.read(recentsProvider.notifier).clearRecents())
            ],
          ),
          SettingsSection(
            title: translate(RoadSageStrings.prefsAbout),
            tiles: [
              SettingsTile(
                title: translate(RoadSageStrings.prefsVersion),
                subtitle: _appVersion,
              )
            ],
          ),
          SettingsSection(
            title: translate(RoadSageStrings.prefsAboutRoadSage),
            tiles: [
              SettingsTile(
                title: translate(RoadSageStrings.prefsProdInfo),
                subtitle: translate(RoadSageStrings.prefsProdInfoSub),
              )
            ],
          )
        ],
      )),
    );
  }

  /// Helper function for setting up theme selection
  Future<ThemeMode?> _chooseColourTheme() async {
    return showDialog<ThemeMode>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(translate(RoadSageStrings.prefsThemeSelect)),
            contentPadding: const EdgeInsets.all(20),
            children: [
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, ThemeMode.system),
                child: Text(translate(RoadSageStrings.prefsThemeSystem)),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, ThemeMode.light),
                child: Text(translate(RoadSageStrings.prefsThemeLight)),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, ThemeMode.dark),
                child: Text(translate(RoadSageStrings.prefsThemeDark)),
              )
            ],
          );
        });
  }

  /// Helper function for setting up language selection
  Future<String?> _chooseLanguage() async {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(translate(RoadSageStrings.prefsLangSelect)),
            contentPadding: const EdgeInsets.all(20),
            children: [
              SimpleDialogOption(
                onPressed: () =>
                    Navigator.pop(context, RoadSageStrings.prefsLangEn),
                child: Text(translate(RoadSageStrings.prefsLangNameEn)),
              ),
              SimpleDialogOption(
                onPressed: () =>
                    Navigator.pop(context, RoadSageStrings.prefsLangFr),
                child: Text(translate(RoadSageStrings.prefsLangNameFr)),
              ),
            ],
          );
        });
  }
}
