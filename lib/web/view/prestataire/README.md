# 🎯 PARTIE PRESTATAIRE - SDEALSAPP

## 📁 Structure du dossier

```
sdealsapp/lib/web/view/prestataire/
├── prestataire.dart                    # Export principal
├── models/                            # Modèles de données
│   └── prestataire_profile.dart       # Modèle profil prestataire
├── prestataire_registration/          # Inscription prestataire
│   ├── bloc/                          # BLoC pattern
│   │   ├── prestataire_registration.dart      # Export BLoC
│   │   ├── prestataire_registration_bloc.dart # Logique métier
│   │   ├── prestataire_registration_event.dart # Événements
│   │   └── prestataire_registration_state.dart # États
│   └── screens/                       # Écrans
│       ├── prestataire_welcome_screen.dart    # Écran d'accueil
│       ├── prestataire_registration_screen.dart # Écran principal
│       └── steps/                     # Étapes du formulaire
│           ├── personal_info_step.dart        # Infos personnelles
│           ├── service_selection_step.dart   # Sélection services
│           ├── pricing_step.dart             # Tarifs
│           └── verification_step.dart         # Vérification
└── prestataire_dashboard/             # Dashboard prestataire
    ├── bloc/                          # BLoC pattern
    │   ├── prestataire_dashboard.dart         # Export BLoC
    │   ├── prestataire_dashboard_bloc.dart    # Logique métier
    │   ├── prestataire_dashboard_event.dart   # Événements
    │   └── prestataire_dashboard_state.dart   # États
    └── screens/                        # Écrans
        └── prestataire_main_screen.dart       # Écran principal
```

## 🚀 Parcours utilisateur

### 1. **Accueil prestataire** (`prestataire_welcome_screen.dart`)
- Présentation des avantages
- Sélection des métiers
- Bouton "COMMENCER MON INSCRIPTION"

### 2. **Inscription prestataire** (`prestataire_registration_screen.dart`)
- **Étape 1** : Informations personnelles
- **Étape 2** : Sélection des services
- **Étape 3** : Tarifs et disponibilités
- **Étape 4** : Vérification et documents

### 3. **Dashboard prestataire** (`prestataire_main_screen.dart`)
- Statistiques
- Missions récentes
- Actions rapides
- Navigation par onglets

## 🎯 Fonctionnalités

### ✅ Inscription
- Formulaire multi-étapes
- Validation en temps réel
- Upload de documents
- Sauvegarde progressive

### ✅ Dashboard
- Vue d'ensemble des performances
- Gestion des missions
- Planning
- Messages
- Profil

### ✅ BLoC Pattern
- Gestion d'état réactive
- Séparation logique/UI
- Événements et états typés

## 🔧 Utilisation

```dart
// Import principal
import 'package:sdealsapp/web/view/prestataire/prestataire.dart';

// Utilisation du BLoC
BlocProvider(
  create: (context) => PrestataireRegistrationBloc(
    apiClient: ApiClient(),
  ),
  child: PrestataireRegistrationScreen(),
)
```

## 📱 Responsive Design

- **Desktop** : Layout horizontal avec sidebar
- **Tablet** : Layout adaptatif
- **Mobile** : Layout vertical optimisé

## 🎨 Design System

- **Couleurs** : Vert SoutraLi (#4CAF50, #2E7D32)
- **Typographie** : Inter, poids 400-700
- **Espacement** : Système 8px
- **Animations** : TweenAnimationBuilder, 300-600ms
- **Hover Effects** : Scale, elevation, shadow

## 🔗 Intégration

### API Client
```dart
// Méthodes requises dans ApiClient
- createPrestataire(Map<String, dynamic> data)
- getPrestataireStats(String id)
- getPrestataireMissions(String id)
- updatePrestataireProfile(String id, Map<String, dynamic> data)
```

### Routing
```dart
// Routes à ajouter dans le router
'/prestataire/welcome' -> PrestataireWelcomeScreen
'/prestataire/registration' -> PrestataireRegistrationScreen
'/prestataire/dashboard' -> PrestataireMainScreen
```

## 🚧 TODO

- [ ] Implémenter les appels API réels
- [ ] Ajouter la gestion des erreurs
- [ ] Implémenter les tests unitaires
- [ ] Ajouter la localisation
- [ ] Optimiser les performances
- [ ] Ajouter les animations avancées
- [ ] Implémenter la gestion des fichiers
- [ ] Ajouter la validation côté serveur






