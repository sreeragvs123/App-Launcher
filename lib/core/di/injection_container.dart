import 'package:get_it/get_it.dart';
import 'package:launcher/data/repositories_impl/app_repository_impl.dart';

import '../../data/datasources/app_remote_datasource.dart';
import '../../domain/repositories/app_repository.dart';
import '../../domain/usecases/get_installed_apps_usecase.dart';
import '../../domain/usecases/launch_app_usecase.dart';
import '../../presentation/bloc/launcher_bloc.dart';

final sl = GetIt.instance; // sl stands for Service Locator

Future<void> initServiceLocator() async {

  sl.registerLazySingleton<AppLocalDataSource>(
    () => AppLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<AppRepository>(
    () => AppRepositoryImpl(sl<AppLocalDataSource>()),
  );


  sl.registerLazySingleton<GetInstalledAppsUseCase>(
    () => GetInstalledAppsUseCase(sl<AppRepository>()),
  );

  sl.registerLazySingleton<LaunchAppUseCase>(
    () => LaunchAppUseCase(sl<AppRepository>()),
  );


  sl.registerFactory<LauncherBloc>(
    () => LauncherBloc(
      getInstalledAppsUseCase: sl<GetInstalledAppsUseCase>(),
      launchAppUseCase: sl<LaunchAppUseCase>(),
    ),
  );
}