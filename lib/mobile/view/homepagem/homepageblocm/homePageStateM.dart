
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageBloc.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageEvent.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageState.dart';

import 'package:sdealsapp/data/models/categorie.dart';


class HomePageStateM extends Equatable {
  final bool isLoading;
  final List<Categorie>? listItems;
  final String? error;

  const HomePageStateM({
    this.isLoading = true,
    this.listItems,
    this.error = '',
  });

  factory HomePageStateM.initial() {
    return const HomePageStateM(
      isLoading: true,
      listItems: null,
      error: '',
    );
  }

  HomePageStateM copyWith({
    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
  }) {
    return HomePageStateM(
      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, listItems, error];
}






