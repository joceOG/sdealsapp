import 'package:equatable/equatable.dart';

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

// ✅ NOUVEAU : Événement pour soumettre l'inscription freelance
class SubmitFreelanceRegistrationEvent extends FreelancePageEventM {
  final Map<String, dynamic> formData;

  const SubmitFreelanceRegistrationEvent({required this.formData});

  @override
  List<Object> get props => [formData];
}
