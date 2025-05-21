import 'package:flutter_bloc/flutter_bloc.dart';
import 'splashscreenEvent.dart';
import 'splashscreenState.dart';

class SplashscreenBloc extends Bloc<SplashscreenEvent, SplashscreenState> {
  SplashscreenBloc() : super(SplashInitial()) {
    on<LoadSplash>((event, emit) async {
      emit(SplashLoading());
      await Future.delayed(Duration(seconds: 3)); // Simuler une tâche (3 secondes)
      emit(SplashLoaded());
    });
  }
}



