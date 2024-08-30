import 'package:flutter_bloc/flutter_bloc.dart';
import 'emarcheEvent.dart';
import 'emarcheState.dart';

class EmarcheBloc extends Bloc<EmarcheEvent, EmarcheState> {
  EmarcheBloc() : super(const EmarcheState(0)) {
    on<Increment>((event, emit) {
      emit(EmarcheState(state.counterValue + 1));
    });

    on<Decrement>((event, emit) {
      emit(EmarcheState(state.counterValue - 1));
    });
  }
}
