import 'package:equatable/equatable.dart';
import 'package:sdealsapp/web/data/models/categorie.dart';

abstract class FreelancePageEventM extends Equatable {
  const FreelancePageEventM();

  @override
  List<Object> get props => [];
}

class LoadCategorieDataM extends FreelancePageEventM {}

class LoadFreelancersEvent extends FreelancePageEventM {}

class FilterByCategoryEvent extends FreelancePageEventM {
  final String? category;
  
  const FilterByCategoryEvent(this.category);
  
  @override
  List<Object> get props => [category ?? ''];
}

class SearchFreelancerEvent extends FreelancePageEventM {
  final String query;
  
  const SearchFreelancerEvent(this.query);
  
  @override
  List<Object> get props => [query];
}

class ClearFiltersEvent extends FreelancePageEventM {}
