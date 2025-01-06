import 'package:flutter_bloc/flutter_bloc.dart';
import 'inscriptionEvent.dart';
import 'inscriptionState.dart';

class InscriptionBloc extends Bloc<InscriptionEvent, Inscriptionstate> {

  InscriptionBloc() : super(const Inscriptionstate(0)) {
    on<Increment>((event, emit) {
      emit(Inscriptionstate(state.counterValue + 1));
    });

    on<Decrement>((event, emit) {
      emit(Inscriptionstate(state.counterValue - 1));
    });
  }
}
