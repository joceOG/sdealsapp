import 'package:equatable/equatable.dart';

// 🎯 ÉTATS D'INSCRIPTION PRESTATAIRE
abstract class PrestataireRegistrationState extends Equatable {
  const PrestataireRegistrationState();

  @override
  List<Object?> get props => [];
}

// 🚀 ÉTAT INITIAL
class PrestataireRegistrationInitial extends PrestataireRegistrationState {
  const PrestataireRegistrationInitial();
}

// ⏳ CHARGEMENT
class PrestataireRegistrationLoading extends PrestataireRegistrationState {
  const PrestataireRegistrationLoading();
}

// 📝 ÉTAT DE FORMULAIRE
class PrestataireRegistrationFormState extends PrestataireRegistrationState {
  final int currentStep;
  final int totalSteps;
  final Map<String, dynamic> formData;
  final bool canGoNext;
  final bool canGoPrevious;
  final String? errorMessage;

  const PrestataireRegistrationFormState({
    required this.currentStep,
    required this.totalSteps,
    required this.formData,
    required this.canGoNext,
    required this.canGoPrevious,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        currentStep,
        totalSteps,
        formData,
        canGoNext,
        canGoPrevious,
        errorMessage,
      ];

  PrestataireRegistrationFormState copyWith({
    int? currentStep,
    int? totalSteps,
    Map<String, dynamic>? formData,
    bool? canGoNext,
    bool? canGoPrevious,
    String? errorMessage,
  }) {
    return PrestataireRegistrationFormState(
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
      formData: formData ?? this.formData,
      canGoNext: canGoNext ?? this.canGoNext,
      canGoPrevious: canGoPrevious ?? this.canGoPrevious,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// ✅ SUCCÈS
class PrestataireRegistrationSuccess extends PrestataireRegistrationState {
  final String message;
  final Map<String, dynamic> prestataireData;

  const PrestataireRegistrationSuccess({
    required this.message,
    required this.prestataireData,
  });

  @override
  List<Object?> get props => [message, prestataireData];
}

// ❌ ÉCHEC
class PrestataireRegistrationFailure extends PrestataireRegistrationState {
  final String error;

  const PrestataireRegistrationFailure({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}

// 🔄 VALIDATION
class PrestataireRegistrationValidating extends PrestataireRegistrationState {
  final int currentStep;

  const PrestataireRegistrationValidating({
    required this.currentStep,
  });

  @override
  List<Object?> get props => [currentStep];
}







