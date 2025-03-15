import 'package:equatable/equatable.dart';
import 'package:sdealsapp/web/data/models/service.dart';

import '../../../../../../data/models/categorie.dart';


class ContentDetailsState extends Equatable {

  final bool? isLoading;
  final List<Service>? listItems;
  final String? error;

  const ContentDetailsState( {
    this.isLoading,
    this.listItems,
    this.error,
  });

  factory ContentDetailsState.initial() {
    return const ContentDetailsState(
      isLoading: true,
      listItems: null,
      error: '',
    );
  }

  ContentDetailsState copyWith({
    bool? isLoading,
    List<Service>? listItems,
    String? error,
  }){
    return ContentDetailsState(

      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [ isLoading, listItems, error ];

}

