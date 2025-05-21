
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../web/data/models/categorie.dart';


class MorePageStateM extends Equatable {

  final bool? isLoading;
  final List<Categorie>? listItems;
  final String? error;


  const MorePageStateM( {

    this.isLoading,
    this.listItems,
    this.error,
  });

  factory MorePageStateM.initial() {
    return const MorePageStateM(
      isLoading: true,
      listItems: null,
      error: '',
    );
  }

  MorePageStateM copyWith({

    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
  }){
    return MorePageStateM(

      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [ isLoading, listItems, error ];
}









