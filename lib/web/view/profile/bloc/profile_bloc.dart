import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/data/services/api_client.dart';
import 'package:sdealsapp/data/services/authCubit.dart';
import 'package:sdealsapp/data/models/utilisateur.dart';
import 'profile_event.dart';
import 'profile_state.dart';

// 🎯 BLOC PROFIL UTILISATEUR
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ApiClient _apiClient;
  final AuthCubit _authCubit;

  ProfileBloc({
    required ApiClient apiClient,
    required AuthCubit authCubit,
  })  : _apiClient = apiClient,
        _authCubit = authCubit,
        super(const ProfileInitial()) {
    // Gestionnaires d'événements
    on<LoadProfile>(_onLoadProfile);
    on<SaveProfile>(_onSaveProfile);
    on<ChangePassword>(_onChangePassword);
    on<ChangeProfilePicture>(_onChangeProfilePicture);
    on<RefreshProfile>(_onRefreshProfile);
    on<ClearProfileError>(_onClearProfileError);
  }

  // 🚀 CHARGER LE PROFIL
  void _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());

    try {
      // Récupérer l'utilisateur depuis AuthCubit
      final authState = _authCubit.state;
      if (authState is AuthAuthenticated) {
        emit(ProfileLoaded(utilisateur: authState.utilisateur));
      } else {
        emit(const ProfileError(error: 'Utilisateur non connecté'));
      }
    } catch (e) {
      emit(ProfileError(error: 'Erreur de chargement: ${e.toString()}'));
    }
  }

  // 💾 SAUVEGARDER LE PROFIL
  void _onSaveProfile(
    SaveProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileSaving());

    try {
      // Appel API pour mettre à jour le profil
      final response = await _apiClient.updateUserProfile({
        'nom': event.nom,
        'prenom': event.prenom,
        'email': event.email,
        'telephone': event.telephone,
        'adresse': event.adresse,
        'ville': event.ville,
        'dateNaissance': event.dateNaissance,
        'genre': event.genre,
        'photoProfil': event.photoProfil,
      });

      if (response['success'] == true) {
        // Mettre à jour l'AuthCubit avec les nouvelles données
        final updatedUser = Utilisateur.fromJson(response['utilisateur']);
        _authCubit.setAuthenticated(
          token: _authCubit.state is AuthAuthenticated
              ? ((_authCubit.state as AuthAuthenticated).token)
              : '',
          utilisateur: updatedUser,
          roles: _authCubit.state is AuthAuthenticated
              ? ((_authCubit.state as AuthAuthenticated).roles)
              : ['CLIENT'],
          activeRole: _authCubit.state is AuthAuthenticated
              ? ((_authCubit.state as AuthAuthenticated).activeRole)
              : 'CLIENT',
        );

        emit(ProfileSaved(
          utilisateur: updatedUser,
          message: 'Profil mis à jour avec succès',
        ));
      } else {
        emit(ProfileError(
          error: response['message'] ?? 'Erreur lors de la sauvegarde',
        ));
      }
    } catch (e) {
      emit(ProfileError(
        error: 'Erreur de connexion: ${e.toString()}',
      ));
    }
  }

  // 🔄 CHANGER LE MOT DE PASSE
  void _onChangePassword(
    ChangePassword event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileSaving());

    try {
      final response = await _apiClient.changePassword({
        'currentPassword': event.currentPassword,
        'newPassword': event.newPassword,
      });

      if (response['success'] == true) {
        emit(ProfileSaved(
          utilisateur: _authCubit.state is AuthAuthenticated
              ? ((_authCubit.state as AuthAuthenticated).utilisateur)
              : Utilisateur(
                  idutilisateur: '',
                  nom: '',
                  prenom: '',
                  email: '',
                  password: '',
                  telephone: '',
                  genre: '',
                ),
          message: 'Mot de passe modifié avec succès',
        ));
      } else {
        emit(ProfileError(
          error: response['message'] ??
              'Erreur lors du changement de mot de passe',
        ));
      }
    } catch (e) {
      emit(ProfileError(
        error: 'Erreur de connexion: ${e.toString()}',
      ));
    }
  }

  // 📸 CHANGER LA PHOTO DE PROFIL
  void _onChangeProfilePicture(
    ChangeProfilePicture event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileSaving());

    try {
      final response = await _apiClient.uploadProfilePicture(event.imagePath);

      if (response['success'] == true) {
        // Mettre à jour l'utilisateur avec la nouvelle photo
        final authState = _authCubit.state;
        if (authState is AuthAuthenticated) {
          final updatedUser = authState.utilisateur.copyWith(
            photoProfil: response['photoUrl'],
          );

          _authCubit.setAuthenticated(
            token: authState.token,
            utilisateur: updatedUser,
            roles: authState.roles,
            activeRole: authState.activeRole,
          );

          emit(ProfileSaved(
            utilisateur: updatedUser,
            message: 'Photo de profil mise à jour',
          ));
        }
      } else {
        emit(ProfileError(
          error: response['message'] ?? 'Erreur lors du téléchargement',
        ));
      }
    } catch (e) {
      emit(ProfileError(
        error: 'Erreur de connexion: ${e.toString()}',
      ));
    }
  }

  // 🔄 ACTUALISER LE PROFIL
  void _onRefreshProfile(
    RefreshProfile event,
    Emitter<ProfileState> emit,
  ) async {
    add(const LoadProfile());
  }

  // ❌ EFFACER L'ERREUR
  void _onClearProfileError(
    ClearProfileError event,
    Emitter<ProfileState> emit,
  ) {
    if (state is ProfileLoaded) {
      final currentState = state as ProfileLoaded;
      emit(currentState.copyWith(successMessage: null));
    }
  }
}
