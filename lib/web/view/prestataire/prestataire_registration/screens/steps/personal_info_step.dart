import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart'; // ✅ Responsive
import 'package:sdealsapp/data/services/api_client.dart';
import 'package:sdealsapp/data/models/categorie.dart';
import 'package:sdealsapp/data/models/service.dart';
import '../../bloc/prestataire_registration.dart';

// 🎯 ÉTAPE INFORMATIONS DE BASE (REDESIGN PREMIUM)
class PersonalInfoStep extends StatefulWidget {
  const PersonalInfoStep({super.key});

  @override
  State<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends State<PersonalInfoStep> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  String? _selectedCategory;
  String? _selectedService;
  List<String> _selectedAreas = [];
  LatLng? _selectedPosition;
  String? _selectedAddress = '';

  // Données réelles chargées depuis le backend
  List<Categorie> _categories = [];
  List<Service> _services = [];
  bool _isLoadingCategories = false;
  bool _isLoadingServices = false;
  final ApiClient _apiClient = ApiClient();

  // Zones disponibles
  final List<String> _availableAreas = [
    'Abidjan',
    'Abobo',
    'Adjamé',
    'Attécoubé',
    'Cocody',
    'Koumassi',
    'Marcory',
    'Plateau',
    'Port-Bouët',
    'Treichville',
    'Yopougon',
    'Bingerville',
    'Yamoussoukro',
    'Bouaké',
    'Daloa',
    'San Pedro',
    'Korhogo',
    'Anyama',
    'Divo'
  ];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // ✅ CHARGER LES VRAIES CATÉGORIES DEPUIS LE BACKEND
  Future<void> _loadCategories() async {
    setState(() {
      _isLoadingCategories = true;
    });

    try {
      final categories = await _apiClient.fetchCategorie("Métiers");
      setState(() {
        _categories = categories;
        _isLoadingCategories = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingCategories = false;
      });
    }
  }

  // ✅ CHARGER LES SERVICES POUR UNE CATÉGORIE SPÉCIFIQUE
  Future<void> _loadServicesForCategory(String categoryId) async {
    setState(() {
      _isLoadingServices = true;
    });

    try {
      final services = await _apiClient.fetchServices("Métiers");
      final filteredServices = services.where((service) {
        return service.categorie?.idcategorie == categoryId;
      }).toList();

      setState(() {
        _services = filteredServices;
        _isLoadingServices = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingServices = false;
      });
    }
  }

  // Obtenir la position actuelle (simplifié)
  Future<void> _getCurrentLocation() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Veuillez entrer votre adresse manuellement')),
    );
  }

  // 🎯 VALIDATION ET SAUVEGARDE
  void _validateAndSave() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategory == null) {
        _showError('Veuillez sélectionner une catégorie');
        return;
      }
      if (_selectedService == null) {
        _showError('Veuillez sélectionner un service');
        return;
      }
      if (_selectedAreas.isEmpty) {
        _showError('Veuillez sélectionner au moins une zone');
        return;
      }

      context.read<PrestataireRegistrationBloc>().add(
            SavePersonalInfoSimplified(
              fullName: _nameController.text,
              phone: _phoneController.text,
              email:
                  _emailController.text.isEmpty ? null : _emailController.text,
              category: _selectedCategory!,
              service: _selectedService!,
              serviceAreas: _selectedAreas,
              position: _selectedPosition ?? const LatLng(5.3600, -4.0083),
              address: _selectedAddress ?? 'Abidjan',
            ),
          );
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (context) => _buildFormContent(isMobile: true),
      desktop: (context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🖼️ IMAGE INSPIRANTE (GAUCHE)
          Expanded(
            flex: 4,
            child: Container(
              height: 800, // Hauteur fixe ou ajustée
              margin: const EdgeInsets.only(right: 32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: const DecorationImage(
                  image: AssetImage('assets/images/african_worker.png'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Overlay gradient
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  // Texte motivationnel
                  Positioned(
                    bottom: 40,
                    left: 32,
                    right: 32,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Votre talent mérite\nd\'être reconnu.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Rejoignez des milliers de prestataires qui développent leur activité chaque jour.',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 📝 FORMULAIRE (DROITE)
          Expanded(
            flex: 6,
            child: _buildFormContent(isMobile: false),
          ),
        ],
      ),
    );
  }

  Widget _buildFormContent({required bool isMobile}) {
    return SingleChildScrollView(
      padding: isMobile ? const EdgeInsets.all(16) : const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre de l'étape
            const Text(
              'Informations de base',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E293B),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Remplissez ces informations essentielles pour commencer votre aventure.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF64748B),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),

            // Nom complet
            _buildTextField(
              controller: _nameController,
              label: 'Nom complet *',
              hint: 'Votre nom complet',
              prefixIcon: Icons.person_outline,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Le nom complet est requis' : null,
            ),
            const SizedBox(height: 24),

            // Téléphone
            _buildTextField(
              controller: _phoneController,
              label: 'Téléphone *',
              hint: 'Ex: +225 07 XX XX XX XX',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Le téléphone est requis' : null,
            ),
            const SizedBox(height: 24),

            // Email (optionnel)
            _buildTextField(
              controller: _emailController,
              label: 'Email (optionnel)',
              hint: 'Si vous avez un email',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'Veuillez entrer un email valide';
                  }
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Catégorie de service
            _buildDropdown(
              label: 'Votre catégorie *',
              value: _selectedCategory,
              items: _isLoadingCategories
                  ? [
                      const DropdownMenuItem(
                          value: null, child: Text('Chargement...'))
                    ]
                  : _categories.map((categorie) {
                      return DropdownMenuItem(
                        value: categorie.idcategorie,
                        child: Text(categorie.nomcategorie),
                      );
                    }).toList(),
              onChanged: _isLoadingCategories
                  ? null
                  : (String? value) {
                      setState(() {
                        _selectedCategory = value;
                        _selectedService = null;
                      });
                      if (value != null) {
                        _loadServicesForCategory(value);
                      }
                    },
              validator: (value) =>
                  value == null ? 'Veuillez sélectionner votre catégorie' : null,
            ),
            const SizedBox(height: 24),

            // Service spécifique
            _buildDropdown(
              label: 'Votre service *',
              value: _selectedService != null &&
                      _services.any((s) => s.idservice == _selectedService)
                  ? _selectedService
                  : null,
              items: _isLoadingServices
                  ? [
                      const DropdownMenuItem(
                          value: null, child: Text('Chargement...'))
                    ]
                  : _services.map((service) {
                      return DropdownMenuItem(
                        value: service.idservice,
                        child: Text(service.nomservice),
                      );
                    }).toList(),
              onChanged: _isLoadingServices
                  ? null
                  : (String? value) {
                      setState(() {
                        _selectedService = value;
                      });
                    },
              validator: (value) =>
                  value == null ? 'Veuillez sélectionner votre service' : null,
            ),
            const SizedBox(height: 32),

            // Zones de service
            const Text(
              'Où travaillez-vous ? *',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _availableAreas.map((zone) {
                final isSelected = _selectedAreas.contains(zone);
                return FilterChip(
                  label: Text(
                    zone,
                    style: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF475569),
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedAreas.add(zone);
                      } else {
                        _selectedAreas.remove(zone);
                      }
                    });
                  },
                  backgroundColor: Colors.white,
                  selectedColor: const Color(0xFF4CAF50),
                  checkmarkColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                      color: isSelected
                          ? Colors.transparent
                          : Colors.grey.shade300,
                    ),
                  ),
                  elevation: isSelected ? 2 : 0,
                  shadowColor: Colors.green.withOpacity(0.3),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),

            // Position exacte (Simplifiée)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Votre position exacte *',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Utilisée pour vous montrer aux clients proches de vous.',
                    style: TextStyle(fontSize: 14, color: Color(0xFF64748B)),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _getCurrentLocation,
                      icon: const Icon(Icons.my_location),
                      label: const Text('Entrer mon adresse'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF1E293B),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Bouton de validation
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _validateAndSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  shadowColor: const Color(0xFF4CAF50).withOpacity(0.4),
                ),
                child: const Text(
                  'Continuer l\'inscription',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // 🎯 CHAMP DE TEXTE PREMIUM
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    IconData? prefixIcon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: const Color(0xFF94A3B8))
                : null,
            hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
            filled: true,
            fillColor: Colors.grey[50], // Fond léger
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none, // Pas de bordure par défaut
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
          ),
        ),
      ],
    );
  }

  // 🎯 DROPDOWN PREMIUM
  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<DropdownMenuItem<String>> items,
    ValueChanged<String?>? onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          items: items,
          onChanged: onChanged,
          validator: validator,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
          ),
        ),
      ],
    );
  }
}
