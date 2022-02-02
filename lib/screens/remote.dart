import 'package:flutter/material.dart';
import 'package:roadsage/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/models.dart';

class RemoteScreen extends ConsumerStatefulWidget {
  const RemoteScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RemoteScreen> createState() => _RemoteScreenState();
}

class _RemoteScreenState extends ConsumerState<RemoteScreen> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: const Text(RoadSageStrings.remote),
      backgroundColor: Colors.transparent,
      titleSpacing: 20,
      toolbarHeight: 75,
      elevation: 0,
      centerTitle: false,
    );

    final remoteModel = ref.watch(remoteModelProvider);

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
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.circle,
                    size: 38,
                    color: remoteModel.status ? Colors.green : Colors.red,
                  ),
                ),
                tileColor: Theme.of(context).primaryColorLight,
                onTap: () => ref
                    .read(remoteModelProvider.notifier)
                    .switchStatus(!remoteModel.status),
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
                  width: 70,
                  child: Row(
                    children: [
                      Text('${remoteModel.batteryLevel}%'),
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
            ],
          ),
        ),
      ),
    );
  }
}
