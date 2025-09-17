
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:sdealsapp/data/models/categorie.dart';


class ProfilPageStateM extends Equatable {

  final bool? isLoading;
  final List<Categorie>? listItems;
  final String? error;


  const ProfilPageStateM( {

    this.isLoading,
    this.listItems,
    this.error,
  });

  factory ProfilPageStateM.initial() {
    return const ProfilPageStateM(
      isLoading: true,
      listItems: null,
      error: '',
    );
  }

  ProfilPageStateM copyWith({

    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
  }){
    return ProfilPageStateM(

      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [ isLoading, listItems, error ];
}









