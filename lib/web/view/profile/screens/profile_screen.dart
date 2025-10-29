import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/data/services/api_client.dart';
import 'package:sdealsapp/data/services/authCubit.dart';
import 'package:sdealsapp/web/widget/appbarwIdget/screens/AppBarWidget.dart';
import '../bloc/profile.dart';

// 🎯 ÉCRAN PROFIL UTILISATEUR MODERNE 2025
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        apiClient: ApiClient(),
        authCubit: context.read<AuthCubit>(),
      )..add(const LoadProfile()),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatefulWidget {
  const _ProfileView();

  @override
  State<_ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<_ProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();
  final _telephoneController = TextEditingController();
  final _adresseController = TextEditingController();
  final _villeController = TextEditingController();
  final _dateNaissanceController = TextEditingController();
  String? _selectedGenre;
  bool _isEditing = false;

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();
    _adresseController.dispose();
    _villeController.dispose();
    _dateNaissanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBarWidget(),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
            setState(() {
              _isEditing = false;
            });
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
              ),
            );
          }

          if (state is ProfileLoaded) {
            _populateFields(state.utilisateur);
            return _buildProfileContent(context, state);
          }

          if (state is ProfileError) {
            return _buildErrorState(context, state);
          }

          return const Center(child: Text('État inconnu'));
        },
      ),
    );
  }

  // 🎯 CONTENU PRINCIPAL
  Widget _buildProfileContent(BuildContext context, ProfileLoaded state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête
          _buildHeader(context, state),
          const SizedBox(height: 32),

          // Informations personnelles
          _buildPersonalInfoCard(context, state),
          const SizedBox(height: 24),

          // Informations de contact
          _buildContactInfoCard(context, state),
          const SizedBox(height: 24),

          // Actions
          _buildActionsCard(context, state),
        ],
      ),
    );
  }

  // 🎯 EN-TÊTE
  Widget _buildHeader(BuildContext context, ProfileLoaded state) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // Photo de profil
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            backgroundImage: state.utilisateur.photoProfil != null
                ? NetworkImage(state.utilisateur.photoProfil!)
                : null,
            child: state.utilisateur.photoProfil == null
                ? Text(
                    '${state.utilisateur.prenom[0]}${state.utilisateur.nom[0]}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 20),

          // Informations utilisateur
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${state.utilisateur.prenom} ${state.utilisateur.nom}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.utilisateur.email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  state.utilisateur.telephone,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // Bouton d'édition
          IconButton(
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
            icon: Icon(
              _isEditing ? Icons.close : Icons.edit,
              color: Colors.white,
              size: 24,
            ),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.2),
              shape: const CircleBorder(),
            ),
          ),
        ],
      ),
    );
  }

  // 🎯 CARTE INFORMATIONS PERSONNELLES
  Widget _buildPersonalInfoCard(BuildContext context, ProfileLoaded state) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, color: Color(0xFF4CAF50)),
                const SizedBox(width: 12),
                const Text(
                  'Informations personnelles',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (_isEditing) ...[
              _buildEditableForm(context),
            ] else ...[
              _buildReadOnlyInfo(state),
            ],
          ],
        ),
      ),
    );
  }

  // 🎯 CARTE INFORMATIONS DE CONTACT
  Widget _buildContactInfoCard(BuildContext context, ProfileLoaded state) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.contact_phone, color: Color(0xFF4CAF50)),
                const SizedBox(width: 12),
                const Text(
                  'Informations de contact',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildContactInfo(state),
          ],
        ),
      ),
    );
  }

  // 🎯 CARTE ACTIONS
  Widget _buildActionsCard(BuildContext context, ProfileLoaded state) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.settings, color: Color(0xFF4CAF50)),
                const SizedBox(width: 12),
                const Text(
                  'Actions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  // 🎯 FORMULAIRE ÉDITABLE
  Widget _buildEditableForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _prenomController,
                  label: 'Prénom',
                  icon: Icons.person_outline,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  controller: _nomController,
                  label: 'Nom',
                  icon: Icons.person_outline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _emailController,
            label: 'Email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _telephoneController,
            label: 'Téléphone',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _adresseController,
                  label: 'Adresse',
                  icon: Icons.location_on_outlined,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  controller: _villeController,
                  label: 'Ville',
                  icon: Icons.location_city_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _dateNaissanceController,
                  label: 'Date de naissance',
                  icon: Icons.cake_outlined,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDropdown(),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Boutons d'action
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = false;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Color(0xFF4CAF50)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Annuler',
                    style: TextStyle(
                      color: Color(0xFF4CAF50),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Sauvegarder',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 🎯 INFORMATIONS EN LECTURE SEULE
  Widget _buildReadOnlyInfo(ProfileLoaded state) {
    return Column(
      children: [
        _buildInfoRow('Prénom', state.utilisateur.prenom),
        _buildInfoRow('Nom', state.utilisateur.nom),
        _buildInfoRow('Email', state.utilisateur.email),
        _buildInfoRow('Téléphone', state.utilisateur.telephone),
        if (state.utilisateur.adresse != null)
          _buildInfoRow('Adresse', state.utilisateur.adresse!),
        if (state.utilisateur.ville != null)
          _buildInfoRow('Ville', state.utilisateur.ville!),
        if (state.utilisateur.dateNaissance != null)
          _buildInfoRow('Date de naissance', state.utilisateur.dateNaissance!),
        _buildInfoRow('Genre', state.utilisateur.genre),
      ],
    );
  }

  // 🎯 INFORMATIONS DE CONTACT
  Widget _buildContactInfo(ProfileLoaded state) {
    return Column(
      children: [
        _buildInfoRow('Email', state.utilisateur.email, Icons.email),
        _buildInfoRow('Téléphone', state.utilisateur.telephone, Icons.phone),
        if (state.utilisateur.adresse != null)
          _buildInfoRow(
              'Adresse', state.utilisateur.adresse!, Icons.location_on),
      ],
    );
  }

  // 🎯 BOUTONS D'ACTION
  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        _buildActionButton(
          icon: Icons.lock_outline,
          title: 'Changer le mot de passe',
          subtitle: 'Modifier votre mot de passe',
          onTap: () => _showChangePasswordDialog(context),
        ),
        const SizedBox(height: 16),
        _buildActionButton(
          icon: Icons.photo_camera_outlined,
          title: 'Changer la photo',
          subtitle: 'Modifier votre photo de profil',
          onTap: () => _changeProfilePicture(),
        ),
        const SizedBox(height: 16),
        _buildActionButton(
          icon: Icons.logout,
          title: 'Se déconnecter',
          subtitle: 'Déconnexion de votre compte',
          onTap: () => _logout(context),
          isDestructive: true,
        ),
      ],
    );
  }

  // 🎯 CHAMP DE TEXTE
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
        ),
      ),
    );
  }

  // 🎯 DROPDOWN GENRE
  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGenre,
      decoration: InputDecoration(
        labelText: 'Genre',
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
        ),
      ),
      items: const [
        DropdownMenuItem(value: 'M', child: Text('Masculin')),
        DropdownMenuItem(value: 'F', child: Text('Féminin')),
        DropdownMenuItem(value: 'A', child: Text('Autre')),
      ],
      onChanged: (value) {
        setState(() {
          _selectedGenre = value;
        });
      },
    );
  }

  // 🎯 LIGNE D'INFORMATION
  Widget _buildInfoRow(String label, String value, [IconData? icon]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.grey.shade600, size: 20),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🎯 BOUTON D'ACTION
  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? Colors.red : const Color(0xFF4CAF50),
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                          isDestructive ? Colors.red : const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey.shade400,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // 🎯 ÉTAT D'ERREUR
  Widget _buildErrorState(BuildContext context, ProfileError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Erreur de chargement',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            state.error,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<ProfileBloc>().add(const RefreshProfile());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Réessayer',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // 🎯 MÉTHODES UTILITAIRES
  void _populateFields(utilisateur) {
    _nomController.text = utilisateur.nom;
    _prenomController.text = utilisateur.prenom;
    _emailController.text = utilisateur.email;
    _telephoneController.text = utilisateur.telephone;
    _adresseController.text = utilisateur.adresse ?? '';
    _villeController.text = utilisateur.ville ?? '';
    _dateNaissanceController.text = utilisateur.dateNaissance ?? '';
    _selectedGenre = utilisateur.genre;
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(SaveProfile(
            nom: _nomController.text,
            prenom: _prenomController.text,
            email: _emailController.text,
            telephone: _telephoneController.text,
            adresse: _adresseController.text.isNotEmpty
                ? _adresseController.text
                : null,
            ville:
                _villeController.text.isNotEmpty ? _villeController.text : null,
            dateNaissance: _dateNaissanceController.text.isNotEmpty
                ? _dateNaissanceController.text
                : null,
            genre: _selectedGenre,
          ));
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 20)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dateNaissanceController.text = picked.toString().split(' ')[0];
    }
  }

  void _showChangePasswordDialog(BuildContext context) {
    // TODO: Implémenter le dialogue de changement de mot de passe
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fonctionnalité à implémenter')),
    );
  }

  void _changeProfilePicture() {
    // TODO: Implémenter le changement de photo de profil
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fonctionnalité à implémenter')),
    );
  }

  void _logout(BuildContext context) {
    context.read<AuthCubit>().logout();
    context.go('/homepage');
  }
}
