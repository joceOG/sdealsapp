import 'package:equatable/equatable.dart';
import 'package:sdealsapp/data/models/categorie.dart';


abstract class MorePageEventM extends Equatable {
  const MorePageEventM();

  @override
  List<Object> get props => [];
}

class LoadCategorieDataM extends MorePageEventM {}


