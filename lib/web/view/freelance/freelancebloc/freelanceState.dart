import 'package:equatable/equatable.dart';
import 'package:sdealsapp/data/models/categorie.dart';
import 'package:sdealsapp/data/models/service.dart';

class FreelanceState extends Equatable {
  final bool? isLoading;
  final List<Categorie>? listItems;
  final String? error;

  // NOUVEAUX CHAMPS POUR LES SERVICES
  final bool? isLoading2;
  final List<Service>? listItems2;
  final String? error2;

  const FreelanceState({
    this.isLoading,
    this.listItems,
    this.error,
    this.isLoading2,
    this.listItems2,
    this.error2,
  });

  factory FreelanceState.initial() {
    return const FreelanceState(
      isLoading: true,
      listItems: null,
      error: '',
      isLoading2: true,
      listItems2: null,
      error2: '',
    );
  }

  FreelanceState copyWith({
    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
    bool? isLoading2,
    List<Service>? listItems2,
    String? error2,
  }) {
    return FreelanceState(
      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
      isLoading2: isLoading2 ?? this.isLoading2,
      listItems2: listItems2 ?? this.listItems2,
      error2: error2 ?? this.error2,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, listItems, error, isLoading2, listItems2, error2];
}
