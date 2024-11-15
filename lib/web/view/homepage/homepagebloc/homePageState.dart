
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageBloc.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageEvent.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageState.dart';

import '../../../data/models/categorie.dart';
import '../../../data/models/groupe.dart';
import '../../../data/models/service.dart';

class HomePageState extends Equatable {

  final bool? isLoading;
  final List<Categorie>? listItems;
  final String? error;


  const HomePageState( {

    this.isLoading,
    this.listItems,
    this.error,
  });

  factory HomePageState.initial() {
    return const HomePageState(
      isLoading: true,
      listItems: null,
      error: '',
    );
  }

  HomePageState copyWith({

    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
  }){
    return HomePageState(

      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [ isLoading, listItems, error ];
}









