import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'launcher_event.dart';
part 'launcher_state.dart';

class LauncherBloc extends Bloc<LauncherEvent, LauncherState> {
  LauncherBloc() : super(LauncherInitial()) {
    on<LauncherEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
