import 'package:equatable/equatable.dart';

abstract class ConnexionEvent extends Equatable {
  const ConnexionEvent();

  @override
  List<Object> get props => [];
}

class LoginRequest extends ConnexionEvent {
  final String email;
  final String password;
  final bool rememberMe;

  const LoginRequest({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  @override
  List<Object> get props => [email, password, rememberMe];
}

class GoogleLoginRequest extends ConnexionEvent {
  const GoogleLoginRequest();
}

class LogoutRequest extends ConnexionEvent {
  const LogoutRequest();
}

class ClearError extends ConnexionEvent {
  const ClearError();
}
