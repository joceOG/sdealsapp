import 'package:flutter_bloc/flutter_bloc.dart';

import 'appbarwidgetEvent.dart';
import 'appbarwidgetState.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuInitialState());

  @override
  Stream<MenuState> mapEventToState(MenuEvent event) async* {
    if (event is HoverMenuEvent) {
      yield MenuVisibleState();
    }
  }

  MenuBloc(): super(MenuInitialState()) {
    on<LoadSplash>((event, emit) async {
      emit(SplashLoading());
      await Future.delayed(Duration(seconds: 3)); // Simuler une tâche (3 secondes)
      emit(SplashLoaded());
    });
  }


}


