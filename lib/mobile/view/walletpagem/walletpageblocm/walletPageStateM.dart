
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:sdealsapp/data/models/categorie.dart';


class WalletPageStateM extends Equatable {

  final bool? isLoading;
  final List<Categorie>? listItems;
  final String? error;


  const WalletPageStateM( {

    this.isLoading,
    this.listItems,
    this.error,
  });

  factory WalletPageStateM.initial() {
    return const WalletPageStateM(
      isLoading: true,
      listItems: null,
      error: '',
    );
  }

  WalletPageStateM copyWith({

    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
  }){
    return WalletPageStateM(

      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [ isLoading, listItems, error ];
}









