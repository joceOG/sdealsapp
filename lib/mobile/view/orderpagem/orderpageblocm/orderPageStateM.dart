
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:sdealsapp/data/models/categorie.dart';


class OrderPageStateM extends Equatable {

  final bool? isLoading;
  final List<Categorie>? listItems;
  final String? error;


  const OrderPageStateM( {

    this.isLoading,
    this.listItems,
    this.error,
  });

  factory OrderPageStateM.initial() {
    return const OrderPageStateM(
      isLoading: true,
      listItems: null,
      error: '',
    );
  }

  OrderPageStateM copyWith({

    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
  }){
    return OrderPageStateM(

      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [ isLoading, listItems, error ];
}









