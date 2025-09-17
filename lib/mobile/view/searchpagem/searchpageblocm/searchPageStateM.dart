
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:sdealsapp/data/models/categorie.dart';


class SearchPageStateM extends Equatable {

  final bool? isLoading;
  final List<Categorie>? listItems;
  final String? error;


  const SearchPageStateM( {

    this.isLoading,
    this.listItems,
    this.error,
  });

  factory SearchPageStateM.initial() {
    return const SearchPageStateM(
      isLoading: true,
      listItems: null,
      error: '',
    );
  }

  SearchPageStateM copyWith({

    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
  }){
    return SearchPageStateM(

      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [ isLoading, listItems, error ];
}









