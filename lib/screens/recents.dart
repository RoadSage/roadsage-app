import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:roadsage/constants.dart';
import 'package:roadsage/state/models.dart';

class RecentsScreen extends ConsumerStatefulWidget {
  const RecentsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RecentsScreen> createState() => _RecentsScreenState();
}

class _RecentsScreenState extends ConsumerState<RecentsScreen> {
  @override
  void didChangeDependencies() {
    final recentsModel = ref.watch(recentsProvider);
    if (recentsModel.recents.isEmpty) {
      recentsModel.getDataFromDb();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final recentsModel = ref.watch(recentsProvider);

    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //This is the heading
            Text(
              translate(RoadSageStrings.communication),
              textScaleFactor: 2,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            //this is the subheading of the page
            Text(
              translate(RoadSageStrings.checkPreview),
              textScaleFactor: 1.2,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //making list tiles for the recent purposes
            ...recentsModel.recents
                .map((e) => _buildCard(
                    title: translate(e.invocationMethod),
                    desc: translate(e.command),
                    timestamp: e.timestamp))
                .toList()
                .reversed,
          ],
        )
      ],
    );
  }

  _buildCard({
    required String title,
    required String desc,
    required DateTime timestamp,
  }) {
    //making a general widget for the display
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        style: ListTileStyle.list,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textScaleFactor: 1.05,
        ),
        subtitle: Text(
          desc,
          textScaleFactor: 1.05,
        ),
        trailing: Text(
          "${timestamp.day}/${timestamp.month}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: Theme.of(context).primaryColorLight,
      ),
    );
  }
}
