import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Map<String, List<Application>> apps = {};
  bool _initialized = false;

  _MenuPageState() {
    _init();
  }

  @override
  Widget build(BuildContext context) {
    var menuSections = <MenuSection>[];
    for (var key in apps.keys.toList()..sort()) {
      menuSections.add(MenuSection(key, apps[key]!));
    }

    return _initialized
        ? ListView(children: menuSections)
        : const Center(child: CircularProgressIndicator());
  }

  void _init() async {
    var notSortedApps = await DeviceApps.getInstalledApplications(
        includeSystemApps: true, onlyAppsWithLaunchIntent: true);
    _initialized = true;
    _sortApps(notSortedApps);
  }

  void _sortApps(List<Application> notSortedApps) {
    for (var app in notSortedApps) {
      var firstLetter = app.appName[0].toUpperCase();
      if (!apps.containsKey(firstLetter)) {
        apps[firstLetter] = [];
      }
      apps[firstLetter]!.add(app);
    }
    for (var list in apps.values) {
      list.sort((a, b) => a.packageName.compareTo(b.packageName));
    }
    setState(() {});
  }
}

class MenuSection extends StatelessWidget {
  final List<Application> apps;
  final String letter;

  const MenuSection(this.letter, this.apps, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(apps.length, (index) => AppCard(apps[index]))
          ..insert(
              0,
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(35, 20, 5, 5),
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Center(
                        child: Text(letter,
                            style: GoogleFonts.ptSansNarrow(
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center)))
              ])));
  }
}

class AppCard extends StatefulWidget {
  final Application app;

  const AppCard(this.app, {super.key});

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _editMode = false;

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
}
