import 'package:flutter_bloc/flutter_bloc.dart';
import 'prestataireEvent.dart';
import 'prestataireState.dart';

class PrestataireBloc extends Bloc<PrestataireEvent, PrestataireState> {

  PrestataireBloc() : super(const PrestataireState(0)) {
    on<Increment>((event, emit) {
      emit(PrestataireState(state.counterValue + 1));
    });

    on<Decrement>((event, emit) {
      emit(PrestataireState(state.counterValue - 1));
    });
  }
}
