import 'package:flutter_bloc/flutter_bloc.dart';
import 'articleEvent.dart';
import 'articleState.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(const ArticleState(0)) {
    on<Increment>((event, emit) {
      emit(ArticleState(state.counterValue + 1));
    });

    on<Decrement>((event, emit) {
      emit(ArticleState(state.counterValue - 1));
    });
  }
}
