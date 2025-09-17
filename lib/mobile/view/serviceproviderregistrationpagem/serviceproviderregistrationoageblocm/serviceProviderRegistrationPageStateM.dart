import 'package:equatable/equatable.dart';

abstract class ServiceProviderRegistrationStateM extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServiceProviderRegistrationInitial extends ServiceProviderRegistrationStateM {}

class ServiceProviderRegistrationLoading extends ServiceProviderRegistrationStateM {}

class ServiceProviderRegistrationSuccess extends ServiceProviderRegistrationStateM {
  final String message;

  ServiceProviderRegistrationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ServiceProviderRegistrationFailure extends ServiceProviderRegistrationStateM {
  final String error;

  ServiceProviderRegistrationFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
