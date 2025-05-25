
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../web/data/models/categorie.dart';


class FreelancePageStateM extends Equatable {

  final bool? isLoading;
  final List<Categorie>? listItems;
  final String? error;


  const FreelancePageStateM( {

    this.isLoading,
    this.listItems,
    this.error,
  });

  factory FreelancePageStateM.initial() {
    return const FreelancePageStateM(
      isLoading: true,
      listItems: null,
      error: '',
    );
  }

  FreelancePageStateM copyWith({

    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
  }){
    return FreelancePageStateM(

      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [ isLoading, listItems, error ];
}









