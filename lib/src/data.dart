import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Data with ChangeNotifier {
  List<Application> _apps = [];
  List<String> _favorites = [];

  List<Application> get apps => _apps;
  List<String> get favorites => _favorites;
  bool get initialized => _apps.isNotEmpty;

  Data() {
    _init();
  }

  void _init() async {
    _apps = await DeviceApps.getInstalledApplications(
        includeAppIcons: true,
        includeSystemApps: true,
        onlyAppsWithLaunchIntent: true);
    var prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList('favorites') ?? [];
    notifyListeners();
  }

  void setFavorite(String packageName, bool favorite) {
    if (favorite && !favorites.contains(packageName)) {
      favorites.add(packageName);
    } else {
      favorites.remove(packageName);
    }
    save();
  }

  void save() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', _favorites);
  }
}
