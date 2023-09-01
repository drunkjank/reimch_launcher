import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class AppCard extends StatefulWidget {
  final Application app;

  const AppCard(this.app, {super.key});

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _editMode = false;
  bool _favorite = false;

  _AppCardState() {
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: TextButton(
            onPressed: () {
              widget.app.openApp();
            },
            onLongPress: () {
              setState(() {
                _editMode = !_editMode;
              });
            },
            child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 3.25),
                decoration: const BoxDecoration(color: Color(0xff202020)),
                child: Row(
                  mainAxisAlignment: _editMode
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.start,
                  children: (_editMode
                      ? [
                          Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: TextButton(
                                  onPressed: () {
                                    if (_favorite) {
                                      removeFromFavorites();
                                    } else {
                                      addToFavorites();
                                    }
                                  },
                                  child: Icon(_favorite
                                      ? Icons.star
                                      : Icons.star_outline))),
                          Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: TextButton(
                                  onPressed: () {
                                    widget.app.openSettingsScreen();
                                  },
                                  child: const Icon(
                                    Icons.settings,
                                  ))),
                          Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: TextButton(
                                  onPressed: () {
                                    DeviceApps.uninstallApp(
                                        widget.app.packageName);
                                  },
                                  child: const Icon(Icons.delete)))
                        ]
                      : [
                          Container(
                              margin: const EdgeInsets.all(5),
                              child: Text(widget.app.appName,
                                  style: GoogleFonts.notoSans()))
                        ]),
                ))));
  }

  void _init() async {
    var prefs = await SharedPreferences.getInstance();
    _favorite = (prefs.getStringList('favorites') ?? [])
        .contains(widget.app.packageName);
    setState(() {});
  }

  void addToFavorites() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites',
        (prefs.getStringList('favorites') ?? [])..add(widget.app.packageName));
    _favorite = true;
    setState(() {});
  }

  void removeFromFavorites() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'favorites',
        (prefs.getStringList('favorites') ?? [])
          ..remove(widget.app.packageName));
    _favorite = false;
    setState(() {});
  }
}
