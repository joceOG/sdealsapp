import 'package:equatable/equatable.dart';
import 'package:sdealsapp/data/models/article.dart';
import 'package:sdealsapp/data/models/categorie.dart';
import 'package:sdealsapp/data/models/vendeur.dart';

class EmarcheState extends Equatable {
  final bool? isLoading;
  final List<Categorie>? listItems;
  final String? error;
  final bool? isLoading2;
  final List<Article>? listItems2;
  final String? error2;
  final bool? isLoading3;
  final List<Vendeur>? listItems3;
  final String? error3;

  const EmarcheState({
    this.isLoading,
    this.listItems,
    this.error,
    this.isLoading2,
    this.listItems2,
    this.error2,
    this.isLoading3,
    this.listItems3,
    this.error3,
  });

  factory EmarcheState.initial() {
    return const EmarcheState(
      isLoading: true,
      listItems: null,
      error: '',
      isLoading2: true,
      listItems2: null,
      error2: '',
      isLoading3: true,
      listItems3: null,
      error3: '',
    );
  }

  EmarcheState copyWith({
    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
    bool? isLoading2,
    List<Article>? listItems2,
    String? error2,
    bool? isLoading3,
    List<Vendeur>? listItems3,
    String? error3,
  }) {
    return EmarcheState(
      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
      isLoading2: isLoading2 ?? this.isLoading2,
      listItems2: listItems2 ?? this.listItems2,
      error2: error2 ?? this.error2,
      isLoading3: isLoading3 ?? this.isLoading3,
      listItems3: listItems3 ?? this.listItems3,
      error3: error3 ?? this.error3,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        listItems,
        error,
        isLoading2,
        listItems2,
        error2,
        isLoading3,
        listItems3,
        error3
      ];
}
