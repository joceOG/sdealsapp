import 'package:equatable/equatable.dart';

abstract class ServiceProviderRegistrationEventM extends Equatable {
  @override
  List<Object?> get props => [];
}

// Quand on envoie le formulaire complet
class SubmitServiceProviderRegistrationEvent extends ServiceProviderRegistrationEventM {
  final Map<String, dynamic> formData;

  SubmitServiceProviderRegistrationEvent({required this.formData});

  @override
  List<Object?> get props => [formData];
}
