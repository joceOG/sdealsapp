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

      // 🎯 RÉCUPÉRER TOUS LES RÔLES DEPUIS L'API
      print('🔄 Récupération des rôles complets pour l\'utilisateur...');
      
      List<String> userRoles = ['CLIENT']; // Rôle de base
      String activeRole = 'CLIENT'; // Rôle par défaut
      
      try {
        // Appeler l'endpoint pour récupérer tous les rôles
        final rolesResponse = await _apiClient.getUserRoles(utilisateur.idutilisateur);
        print('📥 Réponse rôles API: $rolesResponse');
        
        if (rolesResponse['roles'] != null) {
          final rolesList = List<String>.from(rolesResponse['roles']);
          userRoles = rolesList.map((role) => role.toUpperCase()).toList();
          
          // Normaliser les rôles (enlever les doublons, s'assurer que CLIENT est présent)
          userRoles = userRoles.toSet().toList();
          if (!userRoles.contains('CLIENT')) {
            userRoles.insert(0, 'CLIENT');
          }
          
          // Définir le rôle actif (priorité: CLIENT si présent, sinon le premier)
          activeRole = userRoles.contains('CLIENT') ? 'CLIENT' : userRoles.first;
          
          print('✅ Rôles complets récupérés: $userRoles');
          print('✅ Rôle actif défini: $activeRole');
        } else {
          print('⚠️ Aucun rôle trouvé dans la réponse API, utilisation du rôle de base');
        }
      } catch (e) {
        print('❌ Erreur lors de la récupération des rôles: $e');
        print('🔄 Utilisation du rôle de base uniquement');
        
        // Fallback: utiliser le rôle de l'utilisateur si disponible
        if (utilisateur.role != null && utilisateur.role!.isNotEmpty) {
          final userRole = utilisateur.role!.toUpperCase();
          if (userRole != 'CLIENT') {
            userRoles.add(userRole);
          }
          activeRole = userRole;
        }
      }
      
      print('🔍 Rôles finaux assignés: $userRoles');
      print('🔍 Rôle actif final: $activeRole');
      
      _authCubit.setAuthenticated(
        token: token,
        utilisateur: utilisateur,
        roles: userRoles,
        activeRole: activeRole,
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
