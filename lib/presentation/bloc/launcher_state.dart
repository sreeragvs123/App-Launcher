part of 'launcher_bloc.dart';

sealed class LauncherState extends Equatable {
  const LauncherState();
  
  @override
  List<Object> get props => [];
}

final class LauncherInitial extends LauncherState {}
