import 'package:equatable/equatable.dart';
import 'package:sdealsapp/web/data/models/categorie.dart';


abstract class RondPageEventM extends Equatable {
  const RondPageEventM();

  @override
  List<Object> get props => [];
}

class LoadCategorieDataM extends RondPageEventM {}


