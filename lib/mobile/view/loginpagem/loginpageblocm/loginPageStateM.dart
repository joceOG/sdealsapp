import 'package:equatable/equatable.dart';

abstract class LoginPageStateM extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginPageInitialM extends LoginPageStateM {}

class LoginPageLoadingM extends LoginPageStateM {}

class LoginPageSuccessM extends LoginPageStateM {
  final String token;
  final Map<String, dynamic> utilisateur;

  LoginPageSuccessM({required this.token, required this.utilisateur});
}


class LoginPageFailureM extends LoginPageStateM {
  final String error;

  LoginPageFailureM({required this.error});

  @override
  List<Object?> get props => [error];
}
