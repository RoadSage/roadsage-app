import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:roadsage/authentication/auth_services.dart';
import 'package:roadsage/constants.dart';
import 'dart:io' show Platform;
import 'package:flutter_translate/flutter_translate.dart';
import 'package:roadsage/state/api.dart';
import 'package:roadsage/state/ble.dart';
import 'package:roadsage/state/data.dart';
import 'package:roadsage/state/models.dart';

/// Home page of the main screen, contains buttons with RoadSage commands
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    final recentsModel = ref.watch(recentsProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            height: 150,
            child: Column(children: <Widget>[
              const Icon(Icons.mic_none, size: 60),
              Text(
                translate(RoadSageStrings.trySaying),
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ]),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: RoadSageStrings.voiceCommands.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.all(18),
                  leading: const Icon(Icons.message_outlined,
                      size: 28, color: RoadSageColours.lightBlue),
                  onTap: () async {
                    String command =
                        translate(RoadSageStrings.voiceCommands[index]);
                    DateTime timestamp = DateTime.now();

                    // The code below should replace the code following it
                    // when the testing stage is over
                    // Leaving it commented out right now so that it is possible
                    // to present the recents functionality without needing a working
                    // bluetooth device

                    // Send the command to the device through bluetooth
                    BluetoothHandler.sendText(translate(command)).then((value) {
                      if (!value) {
                        Fluttertoast.showToast(
                            msg: "Could not connect to the RoadSage device");
                        return;
                      }

                      // Add issued command to recents
                      ref.read(recentsProvider.notifier).addCommand(
                          RoadSageCommand(
                              invocationMethod:
                                  RoadSageStrings.homeScreenButton,
                              command: command,
                              timestamp: timestamp));

                      // Send the command to the API for data collection
                      addAppCommand(RoadSageStrings.homeScreenButton, command,
                          timestamp, authClass);
                    }).onError((error, stackTrace) {
                      Fluttertoast.showToast(
                          msg: "Could not connect to the RoadSage device");
                    });

                    // // Send the command to the device through bluetooth
                    // BluetoothHandler.sendText(translate(command));
                    //
                    // // Add command to recents
                    // recentsModel.addCommand(RoadSageCommand(
                    //     invocationMethod: RoadSageStrings.homeScreenButton,
                    //     command: command,
                    //     timestamp: timestamp));
                    //
                    // // Send command to the API for data collection
                    // addAppCommand(RoadSageStrings.homeScreenButton, command,
                    //     timestamp, authClass);
                  },
                  title: Text(
                    "${translate((Platform.isAndroid) ? RoadSageStrings.androidAssistantPhrase : RoadSageStrings.iosAssistantPhrase)}, ${translate(RoadSageStrings.voiceCommands[index])}",
                  ),
                  tileColor: Theme.of(context).primaryColorLight,
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 15),
            ),
          ),
        ],
      ),
    );
  }
}
