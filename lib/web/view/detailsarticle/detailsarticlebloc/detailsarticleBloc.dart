import 'package:flutter_bloc/flutter_bloc.dart';
import 'detailsarticleEvent.dart';
import 'detailsarticleState.dart';

class DetailsArticleBloc extends Bloc<DetailsArticleEvent, DetailsArticleState> {

  DetailsArticleBloc() : super(const DetailsArticleState()) {
    on<Increment>((event, emit) {
      emit(state.copyWith( counterValue : state.counterValue! + 1));
    });

    on<Decrement>((event, emit) {
      emit(state.copyWith( counterValue : state.counterValue! + 1));
    });
  }
}
