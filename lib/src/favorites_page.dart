import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'appcard.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Application> favorites = [];
  bool _initialized = false;

  _FavoritesPageState() {
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return _initialized
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
            child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                children: List.generate(
                    favorites.length, (index) => AppCardWithIcon(favorites[index]))))
        : const Center(child: CircularProgressIndicator());
  }

  void _init() async {
    var prefs = await SharedPreferences.getInstance();
    var packageNames = prefs.getStringList('favorites') ?? [];
    for (var packageName in packageNames) {
      var app = await DeviceApps.getApp(packageName, true);
      if (app != null) {
        favorites.add(app);
      } else {
        packageNames.remove(packageName);
      }
    }
    prefs.setStringList('favorites', packageNames);
    _initialized = true;
    setState(() {});
  }
}
