import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launcher/data/repositories_impl/app_repository_impl.dart';

import 'data/datasources/app_remote_datasource.dart';
import 'domain/usecases/get_installed_apps_usecase.dart';
import 'domain/usecases/launch_app_usecase.dart';
import 'presentation/bloc/launcher_bloc.dart';
import 'presentation/bloc/launcher_event.dart';
import 'presentation/views/launcher_home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Dependency Injection Setup
  final dataSource = AppLocalDataSourceImpl();
  final repository = AppRepositoryImpl(dataSource);
  final getInstalledAppsUseCase = GetInstalledAppsUseCase(repository);
  final launchAppUseCase = LaunchAppUseCase(repository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LauncherBloc>(
          create: (context) => LauncherBloc(
            getInstalledAppsUseCase: getInstalledAppsUseCase,
            launchAppUseCase: launchAppUseCase,
          )..add(LoadAppsEvent()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LauncherHomeScreen(),
      ),
    ),
  );
}