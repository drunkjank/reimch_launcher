import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

class ApplicationCard extends StatefulWidget {
  final Application app;

  const ApplicationCard(this.app, {super.key});

  @override
  State<ApplicationCard> createState() => _ApplicationCardState();
}

class _ApplicationCardState extends State<ApplicationCard> {
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
          DeviceApps.uninstallApp(widget.app.packageName);
        },
        child: 
            Column(children: [
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
