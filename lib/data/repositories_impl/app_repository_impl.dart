import '../../domain/entities/app_entity.dart';
import '../../domain/repositories/app_repository.dart';
import '../datasources/app_remote_datasource.dart';

class AppRepositoryImpl implements AppRepository {
  final AppLocalDataSource dataSource;

  AppRepositoryImpl(this.dataSource);

@override
Future<Map<String, List<AppEntity>>> getGroupedApps() async {
  final apps = await dataSource.getInstalledApps();
  apps.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

  Map<String, List<AppEntity>> grouped = {};
  for (var letter in List.generate(26, (i) => String.fromCharCode(65 + i))) {
    grouped[letter] = apps
        .where((app) => app.name.toUpperCase().startsWith(letter))
        .map((model) => AppEntity(
              name: model.name,
              packageName: model.packageName,
              iconBytes: model.iconBytes,
            ))
        .toList();
  }

  return grouped;
}

  @override
  Future<void> launchApp(String packageName) async {
    await dataSource.openApp(packageName);
  }
}