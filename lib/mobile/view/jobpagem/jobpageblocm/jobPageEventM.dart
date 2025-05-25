import 'package:equatable/equatable.dart';
import 'package:sdealsapp/web/data/models/categorie.dart';

import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageBloc.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageEvent.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageState.dart';

abstract class JobPageEventM extends Equatable {
  const JobPageEventM();

  @override
  List<Object> get props => [];
}

class LoadCategorieDataM extends JobPageEventM {}


