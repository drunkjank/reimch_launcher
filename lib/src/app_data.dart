import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:device_apps/device_apps.dart';

class AppData with ChangeNotifier {
  List<Application> apps = [];

  AppData() {
    _init();
  }

  void _init() async {
    apps = await DeviceApps.getInstalledApplications(includeAppIcons: true, includeSystemApps: true, onlyAppsWithLaunchIntent: true);
    apps.sort((a, b) => a.packageName.compareTo(b.packageName));
    notifyListeners();

    var events = DeviceApps.listenToAppsChanges();
    events.listen((ApplicationEvent event) {
      if (event is ApplicationEventInstalled) {
        apps.add(event.application);
        apps.sort((a, b) => a.packageName.compareTo(b.packageName));
        notifyListeners();
      } else if (event is ApplicationEventUninstalled) {
        apps.removeWhere((app) => app.packageName == event.packageName);
        notifyListeners();
      }
    });
  }
}
