
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:sdealsapp/web/view/freelance/freelancebloc/freelanceBloc.dart';
import 'package:sdealsapp/web/view/freelance/freelancebloc/freelanceEvent.dart';
import 'package:sdealsapp/web/view/freelance/freelancebloc/freelanceState.dart';

import 'package:sdealsapp/data/models/categorie.dart';
import 'package:sdealsapp/data/models/groupe.dart';
import 'package:sdealsapp/data/models/service.dart';

class FreelanceState extends Equatable {

  final bool? isLoading;
  final List<Categorie>? listItems;
  final String? error;


  const FreelanceState( {

    this.isLoading,
    this.listItems,
    this.error,
  });

  factory FreelanceState.initial() {
    return const FreelanceState(
      isLoading: true,
      listItems: null,
      error: '',
    );
  }

  FreelanceState copyWith({

    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
  }){
    return FreelanceState(

      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [ isLoading, listItems, error ];
}









