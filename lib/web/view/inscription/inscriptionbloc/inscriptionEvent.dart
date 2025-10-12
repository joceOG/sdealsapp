import 'package:equatable/equatable.dart';

abstract class InscriptionEvent extends Equatable {
  const InscriptionEvent();

  @override
  List<Object> get props => [];
}

class RegisterRequest extends InscriptionEvent {
  final String nom;
  final String prenom;
  final String email;
  final String telephone;
  final String password;
  final String genre;
  final String role;
  final String? datedenaissance;
  final String? note;

  const RegisterRequest({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.telephone,
    required this.password,
    required this.genre,
    required this.role,
    this.datedenaissance,
    this.note,
  });

  @override
  List<Object> get props => [
        nom,
        prenom,
        email,
        telephone,
        password,
        genre,
        role,
        datedenaissance ?? '',
        note ?? ''
      ];
}

class GoogleRegisterRequest extends InscriptionEvent {
  const GoogleRegisterRequest();
}

class ClearError extends InscriptionEvent {
  const ClearError();
}
