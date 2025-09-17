import 'package:equatable/equatable.dart';
import 'package:sdealsapp/data/models/categorie.dart';


abstract class SearchPageEventM extends Equatable {
  const SearchPageEventM();

  @override
  List<Object> get props => [];
}

class LoadCategorieDataM extends SearchPageEventM {}


