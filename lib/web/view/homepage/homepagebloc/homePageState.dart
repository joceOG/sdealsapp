
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
  final bool? isLoading2;
  final List<Service>? listItems2;
  final String? error2;


  const HomePageState( {

    this.isLoading,
    this.listItems,
    this.error,
    this.isLoading2,
    this.listItems2,
    this.error2,
  });

  factory HomePageState.initial() {
    return const HomePageState(
      isLoading: true,
      listItems: null,
      error: '',
      isLoading2: true,
      listItems2: null,
      error2: '',
    );
  }

  HomePageState copyWith({
    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
    bool? isLoading2,
    List<Service>? listItems2,
    String? error2,
  }){
    return HomePageState(
      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
      isLoading2: isLoading2 ?? this.isLoading2,
      listItems2: listItems2 ?? this.listItems2,
      error2: error2 ?? this.error2,
    );
  }

  @override
  List<Object?> get props => [ isLoading, listItems, error, isLoading2, listItems2, error2 ];
}









