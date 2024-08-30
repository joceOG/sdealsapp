import 'package:flutter_bloc/flutter_bloc.dart';
import 'freelanceEvent.dart';
import 'freelanceState.dart';

class FreelanceBloc extends Bloc<FreelanceEvent, FreelanceState> {
  FreelanceBloc() : super(const FreelanceState(0)) {
    on<Increment>((event, emit) {
      emit(FreelanceState(state.counterValue + 1));
    });

    on<Decrement>((event, emit) {
      emit(FreelanceState(state.counterValue - 1));
    });
  }
}
