import 'package:flutter_bloc/flutter_bloc.dart';

import 'appbarwidgetEvent.dart';
import 'appbarwidgetState.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {


  MenuBloc(): super(MenuInitialState()) {
    on<HoverMenuEvent>((event, emit) async {
      emit(MenuVisibleState());
      print("Emit Visible") ;
    });
  }



}


