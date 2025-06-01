import 'package:flutter_bloc/flutter_bloc.dart';
import 'splashscreenEventM.dart';
import 'splashscreenStateM.dart';

class SplashscreenBlocM extends Bloc<SplashscreenEventM, SplashscreenStateM> {
  SplashscreenBlocM() : super(SplashInitialM()) {
    on<LoadSplashM>((event, emit) async {
      emit(SplashLoadingM());
      await Future.delayed(
          const Duration(seconds: 3)); // Simuler une tâche (3 secondes)
      emit(SplashLoadedM());
    });
  }
}
