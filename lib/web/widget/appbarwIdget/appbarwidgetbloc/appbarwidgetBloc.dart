import 'package:flutter_bloc/flutter_bloc.dart';

import 'appbarwidgetEvent.dart';
import 'appbarwidgetState.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {


  MenuBloc(): super(MenuInitialState()) {

    on<HoverMenuEvent>((event, emit) async {
      print("Emit Visible") ;
    });

    on<HoverMenuMetiers>((event, emit) async {
      print("Menu Metiers") ;
    });

  }



}


