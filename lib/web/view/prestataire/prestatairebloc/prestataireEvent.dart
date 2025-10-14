import 'package:equatable/equatable.dart';

abstract class PrestataireEvent extends Equatable {
  const PrestataireEvent();

  @override
  List<Object?> get props => [];
}

class LoadPrestataires extends PrestataireEvent {
  final String? serviceId;
  final String? serviceName;
  final bool? verified;
  final int? limit;

  const LoadPrestataires({
    this.serviceId,
    this.serviceName,
    this.verified,
    this.limit,
  });

  @override
  List<Object?> get props => [serviceId, serviceName, verified, limit];
}

class SearchPrestataires extends PrestataireEvent {
  final String query;

  const SearchPrestataires(this.query);

  @override
  List<Object> get props => [query];
}

class FilterByService extends PrestataireEvent {
  final String serviceId;
  final String serviceName;

  const FilterByService(this.serviceId, this.serviceName);

  @override
  List<Object> get props => [serviceId, serviceName];
}

class LoadMorePrestataires extends PrestataireEvent {}

class ClearFilters extends PrestataireEvent {}

class RefreshPrestataires extends PrestataireEvent {}
