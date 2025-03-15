import 'package:equatable/equatable.dart';

import '../../../../../data/models/categorie.dart';


class ItemContentState extends Equatable {

  final bool? isLoading;
  final List<Categorie>? listItems;
  final String? error;

  const ItemContentState( {
    this.isLoading,
    this.listItems,
    this.error,
  });

  factory ItemContentState.initial() {
    return const ItemContentState(
      isLoading: true,
      listItems: null,
      error: '',
    );
  }

  ItemContentState copyWith({
    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
  }){
    return ItemContentState(

      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [ isLoading, listItems, error ];

}

