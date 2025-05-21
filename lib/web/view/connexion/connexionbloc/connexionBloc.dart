import 'package:flutter_bloc/flutter_bloc.dart';
import 'connexionEvent.dart';
import 'connexionState.dart';

class ConnexionBloc extends Bloc<ConnexionEvent, ConnexionState> {

  ConnexionBloc() : super(const ConnexionState(0)) {
    on<Increment>((event, emit) {
      emit(ConnexionState(state.counterValue + 1));
    });

    on<Decrement>((event, emit) {
      emit(ConnexionState(state.counterValue - 1));
    });
  }
}
