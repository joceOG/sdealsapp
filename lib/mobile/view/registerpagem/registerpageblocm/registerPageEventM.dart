import 'package:equatable/equatable.dart';

abstract class RegisterPageEventM extends Equatable {
  const RegisterPageEventM();

  @override
  List<Object?> get props => [];
}

class RegisterFullNameChanged extends RegisterPageEventM {
  final String fullName;
  const RegisterFullNameChanged(this.fullName);

  @override
  List<Object?> get props => [fullName];
}

class RegisterPhoneChanged extends RegisterPageEventM {
  final String phone;
  const RegisterPhoneChanged(this.phone);

  @override
  List<Object?> get props => [phone];
}

class RegisterPasswordChanged extends RegisterPageEventM {
  final String password;
  const RegisterPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class RegisterConfirmPasswordChanged extends RegisterPageEventM {
  final String confirmPassword;
  const RegisterConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];
}

class RegisterSubmitted extends RegisterPageEventM {}
