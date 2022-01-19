import 'package:flutter/material.dart';
import 'package:roadsage/constants.dart';

class RemoteScreen extends StatefulWidget {
  const RemoteScreen({Key? key}) : super(key: key);

  @override
  State<RemoteScreen> createState() => _RemoteScreenState();
}

class _RemoteScreenState extends State<RemoteScreen> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: const Text(RoadSageStrings.remote),
      titleTextStyle: const TextStyle(fontSize: 28),
      titleSpacing: 20,
      toolbarHeight: 75,
      elevation: 0,
      centerTitle: false,
    );

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: <Widget>[
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
                tileColor: Theme.of(context).primaryColorLight,
              ),
              const SizedBox(height: 15),
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
                tileColor: Theme.of(context).primaryColorLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
