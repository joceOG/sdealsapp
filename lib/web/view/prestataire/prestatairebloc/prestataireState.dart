import 'package:equatable/equatable.dart';
import 'package:sdealsapp/data/models/prestataire.dart';

class PrestataireState extends Equatable {
  final bool isLoading;
  final List<Prestataire>? prestataires;
  final String? error;
  final String? searchQuery;
  final String? selectedServiceId;
  final String? selectedServiceName;
  final bool? verifiedOnly;
  final int currentPage;
  final bool hasMoreData;
  final bool isLoadingMore;

  const PrestataireState({
    this.isLoading = false,
    this.prestataires,
    this.error,
    this.searchQuery,
    this.selectedServiceId,
    this.selectedServiceName,
    this.verifiedOnly,
    this.currentPage = 1,
    this.hasMoreData = true,
    this.isLoadingMore = false,
  });

  factory PrestataireState.initial() {
    return const PrestataireState();
  }

  PrestataireState copyWith({
    bool? isLoading,
    List<Prestataire>? prestataires,
    String? error,
    String? searchQuery,
    String? selectedServiceId,
    String? selectedServiceName,
    bool? verifiedOnly,
    int? currentPage,
    bool? hasMoreData,
    bool? isLoadingMore,
  }) {
    return PrestataireState(
      isLoading: isLoading ?? this.isLoading,
      prestataires: prestataires ?? this.prestataires,
      error: error ?? this.error,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedServiceId: selectedServiceId ?? this.selectedServiceId,
      selectedServiceName: selectedServiceName ?? this.selectedServiceName,
      verifiedOnly: verifiedOnly ?? this.verifiedOnly,
      currentPage: currentPage ?? this.currentPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        prestataires,
        error,
        searchQuery,
        selectedServiceId,
        selectedServiceName,
        verifiedOnly,
        currentPage,
        hasMoreData,
        isLoadingMore,
      ];
}
