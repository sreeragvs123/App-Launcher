import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/haptics.dart';
import '../../domain/usecases/get_installed_apps_usecase.dart';
import '../../domain/usecases/launch_app_usecase.dart';
import 'launcher_event.dart';
import 'launcher_state.dart';

class LauncherBloc extends Bloc<LauncherEvent, LauncherState> {
  final GetInstalledAppsUseCase getInstalledAppsUseCase;
  final LaunchAppUseCase launchAppUseCase;

  LauncherBloc({
    required this.getInstalledAppsUseCase,
    required this.launchAppUseCase,
  }) : super(LauncherInitial()) {
    on<LoadAppsEvent>(_onLoadApps);
    on<SelectLetterEvent>(_onSelectLetter);
    on<ReleaseDragEvent>(_onReleaseDrag);
    on<LaunchAppEvent>(_onLaunchApp);
  }

  Future<void> _onLoadApps(LoadAppsEvent event, Emitter<LauncherState> emit) async {
    emit(LauncherLoading());
    try {
      final grouped = await getInstalledAppsUseCase();
      emit(LauncherLoaded(groupedApps: grouped));
    } catch (e) {
      emit(LauncherError("Failed to load apps: $e"));
    }
  }

  void _onSelectLetter(SelectLetterEvent event, Emitter<LauncherState> emit) {
    if (state is LauncherLoaded) {
      final currentState = state as LauncherLoaded;
      if (currentState.selectedLetter != event.letter) {
        HapticsUtil.selectionTick();
        emit(currentState.copyWith(
          selectedLetter: event.letter,
          isDragging: true,
        ));
      }
    }
  }

  void _onReleaseDrag(ReleaseDragEvent event, Emitter<LauncherState> emit) {
    if (state is LauncherLoaded) {
      final currentState = state as LauncherLoaded;
      emit(currentState.copyWith(
        selectedLetter: null,
        isDragging: false,
      ));
    }
  }

  Future<void> _onLaunchApp(LaunchAppEvent event, Emitter<LauncherState> emit) async {
    await launchAppUseCase(event.packageName);
  }
}