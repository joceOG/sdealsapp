import 'package:equatable/equatable.dart';
import 'package:sdealsapp/web/data/models/categorie.dart';

import 'package:sdealsapp/web/view/freelance/freelancebloc/freelanceBloc.dart';
import 'package:sdealsapp/web/view/freelance/freelancebloc/freelanceEvent.dart';
import 'package:sdealsapp/web/view/freelance/freelancebloc/freelanceState.dart';

abstract class FreelanceEvent extends Equatable {
  const FreelanceEvent();

  @override
  List<Object> get props => [];
}

  class LoadCategorieDataF extends FreelanceEvent {}


