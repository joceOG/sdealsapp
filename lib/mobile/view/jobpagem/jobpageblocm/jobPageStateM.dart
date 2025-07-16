
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageBloc.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageEvent.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageState.dart';

import '../../../../web/data/models/categorie.dart';
import 'package:sdealsapp/ai_services/models/ai_recommendation_model.dart';
import 'package:sdealsapp/ai_services/models/provider_match_explanation.dart';
import 'package:sdealsapp/web/data/models/prestataire.dart';


class JobPageStateM extends Equatable {

  final bool? isLoading;
  final List<Categorie>? listItems;
  final String? error;

  // Estimation de prix IA
  final AIPriceEstimation? priceEstimation;
  final bool? isPriceLoading;
  final String? priceError;

  // Matching prestataires IA
  final List<Prestataire>? matchedProviders;
  final ProviderMatchExplanation? matchExplanation;
  final bool? isMatchingLoading;
  final String? matchError;


  const JobPageStateM( {

    this.isLoading,
    this.listItems,
    this.error,
    this.priceEstimation,
    this.isPriceLoading,
    this.priceError,
    this.matchedProviders,
    this.matchExplanation,
    this.isMatchingLoading,
    this.matchError,
  });

  factory JobPageStateM.initial() {
    return const JobPageStateM(
      isLoading: true,
      listItems: null,
      error: '',
      priceEstimation: null,
      isPriceLoading: false,
      priceError: '',
      matchedProviders: null,
      matchExplanation: null,
      isMatchingLoading: false,
      matchError: '',
    );
  }

  JobPageStateM copyWith({

    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
    AIPriceEstimation? priceEstimation,
    bool? isPriceLoading,
    String? priceError,
    List<Prestataire>? matchedProviders,
    ProviderMatchExplanation? matchExplanation,
    bool? isMatchingLoading,
    String? matchError,
  }){
    return JobPageStateM(

      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
      priceEstimation: priceEstimation ?? this.priceEstimation,
      isPriceLoading: isPriceLoading ?? this.isPriceLoading,
      priceError: priceError ?? this.priceError,
      matchedProviders: matchedProviders ?? this.matchedProviders,
      matchExplanation: matchExplanation ?? this.matchExplanation,
      isMatchingLoading: isMatchingLoading ?? this.isMatchingLoading,
      matchError: matchError ?? this.matchError,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    listItems,
    error,
    priceEstimation,
    isPriceLoading,
    priceError,
    matchedProviders,
    matchExplanation,
    isMatchingLoading,
    matchError,
  ];
}









