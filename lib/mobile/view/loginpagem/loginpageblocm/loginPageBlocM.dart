import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/data/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/models/utilisateur.dart';
import '../../../../data/services/authCubit.dart';
import 'loginPageEventM.dart';
import 'loginPageStateM.dart'; // ton fichier API externe

class LoginPageBlocM extends Bloc<LoginPageEventM, LoginPageStateM> {
  LoginPageBlocM() : super(LoginPageInitialM()) {
    on<LoginSubmittedM>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmittedM event,
      Emitter<LoginPageStateM> emit,
      ) async {
    emit(LoginPageLoadingM());

    final apiClient = ApiClient();
    print('Api COnnexion') ;
    try {
      final response = await apiClient.loginUser(
        identifiant: event.identifiant,
        password: event.password,
        rememberMe: event.rememberMe,
      );

      final token = response["token"] ?? "";
      final utilisateurData = response["utilisateur"] ?? {};

      if (token.isEmpty) {
        emit(LoginPageFailureM(error: "Token manquant dans la réponse"));
        return;
      }

      // ✅ Construire l'objet utilisateur
      final utilisateur = Utilisateur.fromMap(utilisateurData);

      // ✅ Stockage local si rememberMe activé
      if (event.rememberMe) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", token);
        await prefs.setString("utilisateur", jsonEncode(utilisateur.toMap()));
      }



      // ✅ Émettre l'état succès
      emit(LoginPageSuccessM(
        token: token,
        utilisateur: utilisateur.toMap(),
      ));

    } catch (error) {
      final errorMessage = (error is Exception)
          ? error.toString().replaceAll('Exception: ', '')
          : 'Erreur inconnue';
      emit(LoginPageFailureM(error: errorMessage));
    }
  }
}
