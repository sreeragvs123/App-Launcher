import 'package:device_apps/device_apps.dart';
import '../models/app_model.dart';

abstract class AppLocalDataSource {
  Future<List<AppModel>> getInstalledApps();
  Future<void> openApp(String packageName);
}

class AppLocalDataSourceImpl implements AppLocalDataSource {
  @override
  Future<List<AppModel>> getInstalledApps() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    );

    return apps.whereType<ApplicationWithIcon>().map((app) {
      return AppModel(
        name: app.appName,
        packageName: app.packageName,
        iconBytes: app.icon,
      );
    }).toList();
  }

  @override
  Future<void> openApp(String packageName) async {
    DeviceApps.openApp(packageName);
  }
}