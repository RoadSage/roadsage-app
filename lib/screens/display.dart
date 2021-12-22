import 'package:flutter/material.dart';
import 'package:roadsage/constants.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({Key? key}) : super(key: key);

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  double _brightnessSliderValue = 20;
  double _stoppingDistance = 1.5;
  bool _adaptiveBrightness = true;

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

    return Scaffold(
      appBar: appBar,
      backgroundColor: RoadSageColours.lightGrey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
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
              const Text(
                RoadSageStrings.brightnessLevel,
                style: TextStyle(fontSize: 20),
              ),
              Slider(
                value: _brightnessSliderValue,
                max: 100,
                divisions: 20,
                activeColor: RoadSageColours.lightBlue,
                label: _brightnessSliderValue.round().toString() + "%",
                onChanged: (double value) {
                  setState(() {
                    _brightnessSliderValue = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text(
                  RoadSageStrings.adaptiveBrightness,
                  style: TextStyle(fontSize: 20),
                ),
                value: _adaptiveBrightness,
                activeColor: RoadSageColours.lightBlue,
                onChanged: (bool value) {
                  setState(() {
                    _adaptiveBrightness = value;
                  });
                },
              ),
              const SizedBox(height: 40),
              const Text(
                RoadSageStrings.sensor,
                style: TextStyle(fontSize: 26),
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
              const Text(
                RoadSageStrings.stoppingDistance,
                style: TextStyle(fontSize: 20),
              ),
              Slider(
                value: _stoppingDistance,
                min: 1,
                max: 2,
                divisions: 20,
                activeColor: RoadSageColours.lightBlue,
                label: _stoppingDistance.toString() + "s",
                onChanged: (double value) {
                  setState(() {
                    _stoppingDistance = value;
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
