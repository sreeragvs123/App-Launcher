import '../entities/app_entity.dart';
import '../repositories/app_repository.dart';

class GetInstalledAppsUseCase {
  final AppRepository repository;

  GetInstalledAppsUseCase(this.repository);

  Future<Map<String, List<AppEntity>>> call() {
    return repository.getGroupedApps();
  }
}