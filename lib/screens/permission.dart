import 'package:flutter/material.dart';

import '../constants.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20),
                height: 150,
                child: Column(children: const <Widget>[
                  Text(
                    "Request For Access",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Roadsage requireds the following permissions to operate properly",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ]),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.all(18),
                      leading: const Icon(
                        Icons.location_on,
                        size: 28,
                        color: RoadSageColours.lightBlue,
                      ),
                      onTap: () {},
                      title: const Text("Location Access"),
                      subtitle: const Text(
                          "Required 'Always' to get Alexa accurate location related answers"),
                      tileColor: Theme.of(context).primaryColorLight,
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.all(18),
                      leading: const Icon(
                        Icons.mic,
                        size: 28,
                        color: RoadSageColours.lightBlue,
                      ),
                      onTap: () {},
                      title: const Text("Microphone Access"),
                      subtitle: const Text(
                          "Required to make your call audio hearable by the other side while calling"),
                      tileColor: Theme.of(context).primaryColorLight,
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.all(18),
                      leading: const Icon(
                        Icons.person,
                        size: 28,
                        color: RoadSageColours.lightBlue,
                      ),
                      onTap: () {},
                      title: const Text("Contact Access"),
                      subtitle: const Text(
                          "Required to make voice activate calls with contacts from your phone"),
                      tileColor: Theme.of(context).primaryColorLight,
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.all(18),
                      leading: const Icon(
                        Icons.notifications,
                        size: 28,
                        color: RoadSageColours.lightBlue,
                      ),
                      onTap: () {},
                      title: const Text("Notification Access"),
                      subtitle: const Text(
                          "Required to notify you when encounters system;s restriction"),
                      tileColor: Theme.of(context).primaryColorLight,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, Routes.home),
                    child: const Text('GRANT PERMISSION'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
