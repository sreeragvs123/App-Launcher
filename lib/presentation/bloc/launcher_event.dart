import 'package:equatable/equatable.dart';

abstract class LauncherEvent extends Equatable {
  const LauncherEvent();

  @override
  List<Object?> get props => [];
}

class LoadAppsEvent extends LauncherEvent {}

class SelectLetterEvent extends LauncherEvent {
  final String letter;

  const SelectLetterEvent(this.letter);

  @override
  List<Object?> get props => [letter];
}

class ReleaseDragEvent extends LauncherEvent {}

class LaunchAppEvent extends LauncherEvent {
  final String packageName;

  const LaunchAppEvent(this.packageName);

  @override
  List<Object?> get props => [packageName];
}