import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'serviceProviderRegistrationPageEventM.dart';
import 'serviceProviderRegistrationPageStateM.dart';

class ServiceProviderRegistrationBlocM extends Bloc<ServiceProviderRegistrationEventM, ServiceProviderRegistrationStateM> {
  ServiceProviderRegistrationBlocM() : super(ServiceProviderRegistrationInitial()) {
    on<SubmitServiceProviderRegistrationEvent>(_onSubmitRegistration);
  }

  Future<void> _onSubmitRegistration(
      SubmitServiceProviderRegistrationEvent event,
      Emitter<ServiceProviderRegistrationStateM> emit,
      ) async {
    emit(ServiceProviderRegistrationLoading());
       print("Form Data" + event.formData.toString()) ;
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:5000/api/providers/register"), // ⚠️ adapte ton URL API Node
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(event.formData),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        emit(ServiceProviderRegistrationSuccess(message: "Inscription réussie !"));
      } else {
        print('Erreur 1');
        emit(ServiceProviderRegistrationFailure(
          error: "Erreur lors de l’inscription: ${response.body}",
        ));
      }
    } catch (e) {
      print('Erreur 2');
      emit(ServiceProviderRegistrationFailure(error: "ERREUR $e"));
    }
  }
}
