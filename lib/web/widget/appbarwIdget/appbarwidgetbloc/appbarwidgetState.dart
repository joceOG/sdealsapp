import 'package:equatable/equatable.dart';

import '../../../data/models/categorie.dart';

class AppBarWidgetState extends Equatable {

  final bool? isLoading;
  final List<Categorie>? listItems;
  final String? error;

  const AppBarWidgetState( {
    this.isLoading,
    this.listItems,
    this.error,
  });

  factory AppBarWidgetState.initial() {
    return const AppBarWidgetState(
      isLoading: true,
      listItems: null,
      error: '',
    );
  }

  AppBarWidgetState copyWith({
    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
  }){
    return AppBarWidgetState(

      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [ isLoading, listItems, error ];

}

