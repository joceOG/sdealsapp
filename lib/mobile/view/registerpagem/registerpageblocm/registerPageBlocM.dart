import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/services/api_client.dart';
import 'package:http/http.dart' as http;
import 'registerPageStateM.dart';
import 'registerPageEventM.dart';

class RegisterPageBlocM extends Bloc<RegisterPageEventM, RegisterPageStateM> {
  RegisterPageBlocM() : super(const RegisterPageStateM()) {
    on<RegisterFullNameChanged>((event, emit) {
      emit(state.copyWith(fullName: event.fullName));
    });

    on<RegisterPhoneChanged>((event, emit) {
      emit(state.copyWith(phone: event.phone));
    });

    on<RegisterPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<RegisterConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    });

    on<RegisterSubmitted>((event, emit) async {
      if (state.password != state.confirmPassword) {
        emit(state.copyWith(errorMessage: "Les mots de passe ne correspondent pas"));
        return;
      }

      emit(state.copyWith(isSubmitting: true, errorMessage: null));
      ApiClient apiClient = ApiClient();

      try {
        final result = await apiClient.registerUser(
          fullName: state.fullName,
          phone: state.phone,
          password: state.password,
        );

        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, errorMessage: e.toString()));
      }
    });
  }

}
