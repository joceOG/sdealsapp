import 'package:equatable/equatable.dart';
import 'package:sdealsapp/data/models/categorie.dart';
import 'package:sdealsapp/ai_services/models/ai_recommendation_model.dart';
import 'package:sdealsapp/ai_services/models/provider_match_explanation.dart';
import 'package:sdealsapp/data/models/prestataire.dart';
import 'package:sdealsapp/data/models/service.dart';

class JobPageStateM extends Equatable {
  final bool isLoading;
  final List<Categorie> listItems;
  final String error;
  final bool isLoading2;
  final List<Service> listItems2;
  final String error2;


  // Estimation de prix IA
  final AIPriceEstimation? priceEstimation;
  final bool isPriceLoading;
  final String priceError;

  // Matching prestataires IA
  final List<Prestataire> matchedProviders;
  final ProviderMatchExplanation? matchExplanation;
  final bool isMatchingLoading;
  final String matchError;

  const JobPageStateM({
    required this.isLoading,
    required this.listItems,
    required this.error,
    required this.isLoading2,
    required this.listItems2,
    required this.error2,
    this.priceEstimation,
    required this.isPriceLoading,
    required this.priceError,
    required this.matchedProviders,
    this.matchExplanation,
    required this.isMatchingLoading,
    required this.matchError,
  });

  /// État initial "safe"
  factory JobPageStateM.initial() {
    return const JobPageStateM(
      isLoading: true,
      listItems: [], // ✅ liste vide, plus de null
      error: '',
      isLoading2: true,
      listItems2: [],
      error2: '',
      priceEstimation: null,
      isPriceLoading: false,
      priceError: '',
      matchedProviders: [], // ✅ liste vide
      matchExplanation: null,
      isMatchingLoading: false,
      matchError: '',
    );
  }

  JobPageStateM copyWith({
    bool? isLoading,
    List<Categorie>? listItems,
    String? error,
    bool? isLoading2,
    List<Service>? listItems2,
    String? error2,
    AIPriceEstimation? priceEstimation,
    bool? isPriceLoading,
    String? priceError,
    List<Prestataire>? matchedProviders,
    ProviderMatchExplanation? matchExplanation,
    bool? isMatchingLoading,
    String? matchError,
  }) {
    return JobPageStateM(
      isLoading: isLoading ?? this.isLoading,
      listItems: listItems ?? this.listItems,
      error: error ?? this.error,
      isLoading2: isLoading2 ?? this.isLoading2,
      listItems2: listItems2 ?? this.listItems2,
      error2: error2 ?? this.error2,
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
    isLoading2,
    listItems2,
    error2,
    priceEstimation,
    isPriceLoading,
    priceError,
    matchedProviders,
    matchExplanation,
    isMatchingLoading,
    matchError,
  ];
}
