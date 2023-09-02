import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:google_fonts/google_fonts.dart';
import 'appcard.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Map<String, List<Application>> apps = {};
  bool _initialized = false;
  String query = '';

  _MenuPageState() {
    _init();
  }

  @override
  Widget build(BuildContext context) {
    var menuSections = <Widget>[];
    if (query.trim() == '') {
      for (var key in apps.keys.toList()) {
        menuSections.add(MenuSection(key, apps[key]!));
      }
    } else {
      var result = <String, List<Application>>{};
      for (var list in apps.values) {
        String? key;
        for (var app in list) {
          var appName = app.appName.toLowerCase();
          if (appName.contains(query) || appName.startsWith(query)) {
            key = app.appName.substring(0, 1).toLowerCase();
            if (!result.containsKey(key)) {
              result[key] = [];
            }
            result[key]!.add(app);
          }
        }
        if (key != null) {
          menuSections.add(MenuSection(key, result[key]!));
        }
      }
    }

    return _initialized
        ? ListView(children: menuSections
            ..insert(0, Container(margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10), child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xff202020),
                border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(30)),
                hintText: 'Search',
              ),
              onChanged: (text) {
                query = text.toLowerCase();
                setState(() {});
              }
            ))))
        : const Center(child: CircularProgressIndicator());
  }

  void _init() async {
    var notSortedApps = await DeviceApps.getInstalledApplications(
        includeSystemApps: true, onlyAppsWithLaunchIntent: true);
    _initialized = true;
    _sortApps(notSortedApps);
  }

  void _sortApps(List<Application> notSortedApps) {
    notSortedApps.sort((a, b) => a.appName.compareTo(b.appName));
    for (var app in notSortedApps) {
      var firstLetter = app.appName[0].toUpperCase();
      if (!apps.containsKey(firstLetter)) {
        apps[firstLetter] = [];
      }
      apps[firstLetter]!.add(app);
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
