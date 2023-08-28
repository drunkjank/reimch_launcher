import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:provider/provider.dart';
import 'data.dart';

class ApplicationCard extends StatefulWidget {
  final Application app;
  bool favorite;

  ApplicationCard(this.app, {this.favorite = false, super.key});

  @override
  State<ApplicationCard> createState() => _ApplicationCardState();
}

class _ApplicationCardState extends State<ApplicationCard> {
  bool editMode = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: FilledButton(
        style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Color(0x00000000)),
        ),
        onPressed: () {
          widget.app.openApp();
        },
        onLongPress: () {
          editMode = !editMode;
        },
        child: editMode
            ? Column(children: [
                ElevatedButton(
                    onPressed: () {
                      context.watch<Data>().setFavorite(
                          widget.app.packageName, !widget.favorite);
                      setState(() {});
                    },
                    child: Icon(widget.favorite
                        ? Icons.push_pin
                        : Icons.push_pin_outlined)),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    DeviceApps.uninstallApp(widget.app.packageName);
                    editMode = false;
                  },
                  child: const Icon(Icons.delete),
                )
              ])
            : Column(children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Image.memory((widget.app as ApplicationWithIcon).icon),
                ),
                Flexible(
                  child: Text(
                    widget.app.appName,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
      ),
    );
  }
}
