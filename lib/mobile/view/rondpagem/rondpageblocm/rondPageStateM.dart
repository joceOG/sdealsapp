
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../web/data/models/categorie.dart';


class RondPageStateM extends Equatable {

  final bool? isLoading;
  final List<Categorie>? listItems;
  final String? error;


  const RondPageStateM( {

    this.isLoading,
    this.listItems,
    this.error,
  });

  factory RondPageStateM.initial() {
    return const RondPageStateM(
      isLoading: true,
      listItems: null,
      error: '',
    );
  }

  RondPageStateM copyWith({

    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
  }){
    return RondPageStateM(

      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [ isLoading, listItems, error ];
}









