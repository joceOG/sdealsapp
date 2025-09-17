import 'package:equatable/equatable.dart';

abstract class LoginPageEventM extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginSubmittedM extends LoginPageEventM {
  final String identifiant;
  final String password;
  final bool rememberMe;

  LoginSubmittedM({
    required this.identifiant,
    required this.password,
    this.rememberMe = false,
  });

  @override
  List<Object?> get props => [identifiant, password, rememberMe];
}
