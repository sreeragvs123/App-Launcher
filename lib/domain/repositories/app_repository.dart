import '../entities/app_entity.dart';

abstract class AppRepository {
  Future<Map<String, List<AppEntity>>> getGroupedApps();
  Future<void> launchApp(String packageName);
}