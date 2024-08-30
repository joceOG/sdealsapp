import 'package:flutter_bloc/flutter_bloc.dart';
import 'autreEvent.dart';
import 'autreState.dart';

class AutreBloc extends Bloc<AutreEvent, AutreState> {
  AutreBloc() : super(const AutreState(0)) {
    on<Increment>((event, emit) {
      emit(AutreState(state.counterValue + 1));
    });

    on<Decrement>((event, emit) {
      emit(AutreState(state.counterValue - 1));
    });
  }
}
