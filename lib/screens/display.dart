import 'package:flutter/material.dart';
import 'package:roadsage/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/models.dart';

class DisplayScreen extends ConsumerStatefulWidget {
  const DisplayScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends ConsumerState<DisplayScreen> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: const Text(RoadSageStrings.display),
      titleTextStyle: const TextStyle(fontSize: 28, color: Colors.black),
      titleSpacing: 20,
      backgroundColor: RoadSageColours.lightGrey,
      toolbarHeight: 75,
      elevation: 0,
      centerTitle: false,
    );

    final displayModel = ref.watch(displayModelProvider);

    return Scaffold(
      appBar: appBar,
      backgroundColor: RoadSageColours.lightGrey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: const Text(
                  RoadSageStrings.status,
                  style: TextStyle(fontSize: 20),
                ),
                trailing: const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.circle,
                    size: 38,
                    color: Colors.green,
                  ),
                ),
                tileColor: Colors.white,
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  RoadSageStrings.brightnessLevel,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Slider(
                value: displayModel.brightnessLevel,
                max: 100,
                divisions: 20,
                activeColor: RoadSageColours.lightBlue,
                label: displayModel.brightnessLevel.round().toString() + "%",
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
                title: const Text(
                  RoadSageStrings.adaptiveBrightness,
                  style: TextStyle(fontSize: 20),
                ),
                value: displayModel.adaptiveBrightness,
                activeColor: RoadSageColours.lightBlue,
                onChanged: (bool value) {
                  setState(() {
                    ref
                        .read(displayModelProvider.notifier)
                        .toggleAdaptiveBrightness(value);
                  });
                },
              ),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  RoadSageStrings.sensor,
                  style: TextStyle(fontSize: 26),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                contentPadding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: const Text(
                  RoadSageStrings.status,
                  style: TextStyle(fontSize: 20),
                ),
                trailing: const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.circle,
                    size: 38,
                    color: Colors.green,
                  ),
                ),
                tileColor: Colors.white,
              ),
              const SizedBox(height: 20),
              ListTile(
                contentPadding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                title: const Text(
                  RoadSageStrings.batteryLevel,
                  style: TextStyle(fontSize: 20),
                ),
                trailing: SizedBox(
                  width: 80,
                  child: Row(
                    children: const [
                      Text('100%'),
                      Icon(
                        Icons.battery_std_outlined,
                        size: 38,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                tileColor: Colors.white,
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  RoadSageStrings.stoppingDistance,
                  style: TextStyle(fontSize: 20),
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
