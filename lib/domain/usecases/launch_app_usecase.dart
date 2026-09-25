import '../repositories/app_repository.dart';

class LaunchAppUseCase {
  final AppRepository repository;

  LaunchAppUseCase(this.repository);

  Future<void> call(String packageName) {
    return repository.launchApp(packageName);
  }
}