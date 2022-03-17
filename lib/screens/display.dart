import 'package:flutter/material.dart';
import 'package:roadsage/authentication/auth_services.dart';
import 'package:roadsage/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/models.dart';
import 'package:flutter_translate/flutter_translate.dart';

class DisplayScreen extends ConsumerStatefulWidget {
  const DisplayScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends ConsumerState<DisplayScreen> {
  final AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text(translate(RoadSageStrings.display)),
      backgroundColor: Colors.transparent,
      titleSpacing: 20,
      toolbarHeight: 75,
      elevation: 0,
      centerTitle: false,
    );

    final displayModel = ref.watch(displayModelProvider);

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: Text(
                  translate(RoadSageStrings.status),
                  style: const TextStyle(fontSize: 20),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.circle,
                    size: 38,
                    color:
                        displayModel.displayStatus ? Colors.green : Colors.red,
                  ),
                ),
                tileColor: Theme.of(context).primaryColorLight,
                onTap: () => ref
                    .read(displayModelProvider.notifier)
                    .switchDisplayStatus(!displayModel.displayStatus),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  translate(RoadSageStrings.brightnessLevel),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Slider(
                value: displayModel.brightnessLevel,
                max: 100,
                divisions: 20,
                activeColor: RoadSageColours.lightBlue,
                label: "${displayModel.brightnessLevel.round()}%",
                onChanged: (double value) {
                  setState(() {
                    ref
                        .read(displayModelProvider.notifier)
                        .updateBrightnessLevel(value);
                  });
                },
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: Text(
                  translate(RoadSageStrings.adaptiveBrightness),
                  style: const TextStyle(fontSize: 20),
                ),
                value: displayModel.adaptiveBrightness,
                activeColor: RoadSageColours.lightBlue,
                onChanged: (bool value) {
                  setState(() {
                    ref
                        .read(displayModelProvider.notifier)
                        .switchAdaptiveBrightness(value);
                  });
                },
              ),
              const SizedBox(height: 40),
              Center(
                child: Text(
                  translate(RoadSageStrings.sensor),
                  style: const TextStyle(fontSize: 26),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                contentPadding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: Text(
                  translate(RoadSageStrings.status),
                  style: const TextStyle(fontSize: 20),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.circle,
                    size: 38,
                    color:
                        displayModel.sensorStatus ? Colors.green : Colors.red,
                  ),
                ),
                tileColor: Theme.of(context).primaryColorLight,
                onTap: () => ref
                    .read(displayModelProvider.notifier)
                    .switchSensorStatus(!displayModel.sensorStatus),
              ),
              const SizedBox(height: 20),
              ListTile(
                contentPadding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: Text(
                  translate(RoadSageStrings.batteryLevel),
                  style: const TextStyle(fontSize: 20),
                ),
                trailing: SizedBox(
                  width: 70,
                  child: Row(
                    children: [
                      Text('${displayModel.batteryLevel}%'),
                      Icon(
                        Icons.battery_std_outlined,
                        size: 38,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ],
                  ),
                ),
                tileColor: Theme.of(context).primaryColorLight,
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  translate(RoadSageStrings.stoppingDistance),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Slider(
                value: displayModel.stoppingDistance,
                min: 1,
                max: 2,
                divisions: 20,
                activeColor: RoadSageColours.lightBlue,
                label: displayModel.stoppingDistance.toString() + "s",
                onChanged: (double value) {
                  setState(() {
                    ref
                        .read(displayModelProvider.notifier)
                        .updateStoppingDistance(value);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
