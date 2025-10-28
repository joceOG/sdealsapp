import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/data/services/api_client.dart';
import 'package:sdealsapp/data/models/utilisateur.dart';
import 'package:sdealsapp/data/services/authCubit.dart';
import 'connexionEvent.dart';
import 'connexionState.dart';

class ConnexionBloc extends Bloc<ConnexionEvent, ConnexionState> {
  final ApiClient _apiClient = ApiClient();
  final AuthCubit _authCubit;

  ConnexionBloc({required AuthCubit authCubit})
      : _authCubit = authCubit,
        super(const ConnexionState()) {
    on<LoginRequest>(_onLoginRequest);
    on<GoogleLoginRequest>(_onGoogleLoginRequest);
    on<LogoutRequest>(_onLogoutRequest);
    on<ClearError>(_onClearError);
  }

  Future<void> _onLoginRequest(
    LoginRequest event,
    Emitter<ConnexionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      print('🔄 Tentative de connexion pour: ${event.email}');

      final result = await _apiClient.loginUser(
        identifiant: event.email, // email peut être email ou téléphone
        password: event.password,
        rememberMe: event.rememberMe,
      );

      print('✅ Connexion réussie: ${result.keys}');

      final utilisateur = Utilisateur.fromJson(result['utilisateur']);
      final token = result['token'];

      // 🎯 Mettre à jour l'AuthCubit global
      _authCubit.setAuthenticated(
        token: token,
        utilisateur: utilisateur,
        roles: [utilisateur.role ?? 'CLIENT'],
        activeRole: utilisateur.role ?? 'CLIENT',
      );

      emit(state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        utilisateur: utilisateur,
        token: token,
      ));
    } catch (e) {
      print('❌ Erreur de connexion: $e');
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onGoogleLoginRequest(
    GoogleLoginRequest event,
    Emitter<ConnexionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      // TODO: Implémenter l'authentification Google
      print('🔄 Tentative de connexion Google...');

      // Pour l'instant, simuler une erreur
      emit(state.copyWith(
        isLoading: false,
        error: 'Authentification Google non implémentée',
      ));
    } catch (e) {
      print('❌ Erreur Google: $e');
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> _onLogoutRequest(
    LogoutRequest event,
    Emitter<ConnexionState> emit,
  ) async {
    emit(const ConnexionState());
  }

  Future<void> _onClearError(
    ClearError event,
    Emitter<ConnexionState> emit,
  ) async {
    emit(state.copyWith(error: null));
  }
}
