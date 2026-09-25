import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection_container.dart';
import 'presentation/bloc/launcher_bloc.dart';
import 'presentation/bloc/launcher_event.dart';
import 'presentation/views/launcher_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetIt dependency injection
  await initServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LauncherBloc>(
          // Inject LauncherBloc via GetIt
          create: (context) => sl<LauncherBloc>()..add(LoadAppsEvent()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LauncherHomeScreen(),
      ),
    );
  }
}