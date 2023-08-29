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
    (await DeviceApps.getInstalledApplications(
            includeAppIcons: true,
            includeSystemApps: true,
            onlyAppsWithLaunchIntent: true))
        .forEach((Application app) {
      installApp(app);
    });
    var prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList('favorites') ?? [];

    var events = DeviceApps.listenToAppsChanges();
    events.listen((ApplicationEvent event) {
      if (event is ApplicationEventInstall) {
        installApp(event.app);
      } else if (event is ApplicationEventUninstall) {
        removeApp(event.app);
      }
    });
  }

  void setFavorite(String packageName, bool favorite) {
    if (favorite && !favorites.contains(packageName)) {
      favorites.add(packageName);
    } else {
      favorites.remove(packageName);
    }
    save();
    notifyListeners();
  }

  void save() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', _favorites);
  }

  void installApp(Application app) {
    _apps.add(app);
    notifyListeners();
  }

  void removeApp(Application app) {
    _apps.remove(app);
    setFavorite(app.packageName, false);
  }
}
