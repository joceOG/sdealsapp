import 'package:flutter_bloc/flutter_bloc.dart';
import 'homePageEvent.dart';
import 'homePageState.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(const HomePageState(0)) {
    on<Increment>((event, emit) {
      emit(HomePageState(state.counterValue + 1));
    });

    on<Decrement>((event, emit) {
      emit(HomePageState(state.counterValue - 1));
    });
  }
}
