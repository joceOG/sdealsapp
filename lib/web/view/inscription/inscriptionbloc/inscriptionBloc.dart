import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/data/services/api_client.dart';
import 'package:sdealsapp/data/models/utilisateur.dart';
import 'inscriptionEvent.dart';
import 'inscriptionState.dart';

class InscriptionBloc extends Bloc<InscriptionEvent, InscriptionState> {
  final ApiClient _apiClient = ApiClient();

  InscriptionBloc() : super(const InscriptionState()) {
    on<RegisterRequest>(_onRegisterRequest);
    on<GoogleRegisterRequest>(_onGoogleRegisterRequest);
    on<ClearError>(_onClearError);
  }

  Future<void> _onRegisterRequest(
    RegisterRequest event,
    Emitter<InscriptionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      print('🔄 Tentative d\'inscription pour: ${event.email}');

      // Utiliser email OU téléphone selon ce qui est fourni
      final contactInfo =
          event.email.isNotEmpty ? event.email : event.telephone;

      final result = await _apiClient.registerUser(
        fullName: '${event.nom} ${event.prenom}',
        phone: contactInfo, // Email ou téléphone
        password: event.password,
      );

      print('✅ Inscription réussie: ${result.keys}');

      final utilisateur = Utilisateur.fromJson(result['utilisateur']);
      final token = result['token'];

      emit(state.copyWith(
        isLoading: false,
        isRegistered: true,
        utilisateur: utilisateur,
        token: token,
      ));
    } catch (e) {
      print('❌ Erreur d\'inscription: $e');
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onGoogleRegisterRequest(
    GoogleRegisterRequest event,
    Emitter<InscriptionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      // TODO: Implémenter l'inscription Google
      print('🔄 Tentative d\'inscription Google...');

      // Pour l'instant, simuler une erreur
      emit(state.copyWith(
        isLoading: false,
        error: 'Inscription Google non implémentée',
      ));
    } catch (e) {
      print('❌ Erreur Google: $e');
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onClearError(
    ClearError event,
    Emitter<InscriptionState> emit,
  ) async {
    emit(state.copyWith(error: null));
  }
}
