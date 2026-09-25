import 'package:installed_apps/installed_apps.dart';
import 'package:installed_apps/app_info.dart';
import '../models/app_model.dart';

abstract class AppLocalDataSource {
  Future<List<AppModel>> getInstalledApps();
  Future<void> openApp(String packageName);
}

class AppLocalDataSourceImpl implements AppLocalDataSource {
  @override
  Future<List<AppModel>> getInstalledApps() async {
    List<AppInfo> apps = await InstalledApps.getInstalledApps(
      excludeSystemApps: false, // Set to false to include system apps
      withIcon: true,          // Set to true to fetch app icons
    );

    return apps.map((app) {
      return AppModel(
        name: app.name,
        packageName: app.packageName,
        iconBytes: app.icon,
      );
    }).toList();
  }

  @override
  Future<void> openApp(String packageName) async {
    await InstalledApps.startApp(packageName);
  }
}