import 'package:equatable/equatable.dart';
import 'package:sdealsapp/data/models/categorie.dart';

import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageBloc.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageEvent.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageState.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class LoadCategorieData extends HomePageEvent {
  final bool forceRefresh;
  const LoadCategorieData({this.forceRefresh = false});
  
  @override
  List<Object> get props => [forceRefresh];
}

class LoadServiceData extends HomePageEvent {
  final bool forceRefresh;
  const LoadServiceData({this.forceRefresh = false});
  
  @override
  List<Object> get props => [forceRefresh];
}



