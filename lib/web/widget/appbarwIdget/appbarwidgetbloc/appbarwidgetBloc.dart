import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/categorie.dart';
import '../../../data/services/api_client.dart';
import 'appbarwidgetEvent.dart';
import 'appbarwidgetState.dart';

class AppBarWidgetBloc extends Bloc<AppBarWidgetEvent, AppBarWidgetState> {


  AppBarWidgetBloc(): super(AppBarWidgetState.initial()) {
    on<HoverMenuEvent>((event, emit) async {
      print("Emit Visible");
    });
  }
  }



