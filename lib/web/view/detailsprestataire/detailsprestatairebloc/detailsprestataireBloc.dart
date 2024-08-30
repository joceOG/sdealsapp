import 'package:flutter_bloc/flutter_bloc.dart';
import 'detailsprestataireEvent.dart';
import 'detailsprestataireState.dart';

class DetailsPrestataireBloc extends Bloc<DetailsPrestataireEvent, DetailsPrestataireState> {

  DetailsPrestataireBloc() : super(const DetailsPrestataireState(0)) {
    on<Increment>((event, emit) {
      emit(DetailsPrestataireState(state.counterValue + 1));
    });

    on<Decrement>((event, emit) {
      emit(DetailsPrestataireState(state.counterValue - 1));
    });
  }
}
