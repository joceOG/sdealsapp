import 'package:equatable/equatable.dart';
import 'package:sdealsapp/data/models/categorie.dart';


abstract class ProfilPageEventM extends Equatable {
  const ProfilPageEventM();

  @override
  List<Object> get props => [];
}

class LoadCategorieDataM extends ProfilPageEventM {}


