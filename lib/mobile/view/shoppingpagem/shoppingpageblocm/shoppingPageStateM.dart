
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../web/data/models/categorie.dart';


class ShoppingPageStateM extends Equatable {

  final bool? isLoading;
  final List<Categorie>? listItems;
  final String? error;


  const ShoppingPageStateM( {

    this.isLoading,
    this.listItems,
    this.error,
  });

  factory ShoppingPageStateM.initial() {
    return const ShoppingPageStateM(
      isLoading: true,
      listItems: null,
      error: '',
    );
  }

  ShoppingPageStateM copyWith({

    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
  }){
    return ShoppingPageStateM(

      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [ isLoading, listItems, error ];
}









