import 'package:equatable/equatable.dart';
import '../../domain/entities/app_entity.dart';

abstract class LauncherState extends Equatable {
  const LauncherState();

  @override
  List<Object?> get props => [];
}

class LauncherInitial extends LauncherState {}

class LauncherLoading extends LauncherState {}

class LauncherLoaded extends LauncherState {
  final Map<String, List<AppEntity>> groupedApps;
  final String? selectedLetter;
  final bool isDragging;

  const LauncherLoaded({
    required this.groupedApps,
    this.selectedLetter,
    this.isDragging = false,
  });

  List<AppEntity> get filteredApps =>
      selectedLetter != null ? (groupedApps[selectedLetter] ?? []) : [];

  List<AppEntity> get favourites =>
      groupedApps.values.expand((e) => e).take(6).toList();

  LauncherLoaded copyWith({
    Map<String, List<AppEntity>>? groupedApps,
    String? selectedLetter,
    bool? isDragging,
  }) {
    return LauncherLoaded(
      groupedApps: groupedApps ?? this.groupedApps,
      selectedLetter: selectedLetter,
      isDragging: isDragging ?? this.isDragging,
    );
  }

  @override
  List<Object?> get props => [groupedApps, selectedLetter, isDragging];
}

class LauncherError extends LauncherState {
  final String message;

  const LauncherError(this.message);

  @override
  List<Object?> get props => [message];
}