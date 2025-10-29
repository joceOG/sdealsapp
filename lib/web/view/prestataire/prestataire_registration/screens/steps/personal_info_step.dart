import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sdealsapp/data/services/api_client.dart';
import 'package:sdealsapp/data/models/categorie.dart';
import 'package:sdealsapp/data/models/service.dart';
import '../../bloc/prestataire_registration.dart';

// 🎯 ÉTAPE INFORMATIONS DE BASE (SIMPLIFIÉE - MODÈLE MOBILE)
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
  // Note: Géolocalisation simplifiée - on utilise juste un champ texte pour l'adresse

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
      print('🔄 Chargement des catégories pour le groupe "Métiers"...');
      final categories = await _apiClient.fetchCategorie("Métiers");

      setState(() {
        _categories = categories;
        _isLoadingCategories = false;
      });

      print('✅ ${categories.length} catégories chargées depuis le backend');
    } catch (e) {
      print('❌ Erreur chargement catégories: $e');
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
      print('🔄 Chargement des services pour la catégorie: $categoryId');
      final services = await _apiClient.fetchServices("Métiers");

      // Filtrer les services par catégorie
      final filteredServices = services.where((service) {
        return service.categorie?.idcategorie == categoryId;
      }).toList();

      setState(() {
        _services = filteredServices;
        _isLoadingServices = false;
      });

      print('✅ ${filteredServices.length} services chargés pour la catégorie');
    } catch (e) {
      print('❌ Erreur chargement services: $e');
      setState(() {
        _isLoadingServices = false;
      });
    }
  }

  // Obtenir la position actuelle (simplifié - pour l'instant on demande juste l'adresse)
  Future<void> _getCurrentLocation() async {
    // Pour l'instant, on peut juste afficher un message
    // On pourra ajouter geolocator plus tard si nécessaire
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Veuillez entrer votre adresse manuellement')),
    );
  }

  // 🎯 VALIDATION ET SAUVEGARDE
  void _validateAndSave() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Veuillez sélectionner une catégorie')),
        );
        return;
      }

      if (_selectedService == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Veuillez sélectionner un service')),
        );
        return;
      }

      if (_selectedAreas.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Veuillez sélectionner au moins une zone')),
        );
        return;
      }

      // Pour l'instant, on accepte sans position GPS (juste l'adresse)
      // Sauvegarder dans le BLoC avec le format simplifié
      context.read<PrestataireRegistrationBloc>().add(
            SavePersonalInfoSimplified(
              fullName: _nameController.text,
              phone: _phoneController.text,
              email:
                  _emailController.text.isEmpty ? null : _emailController.text,
              category: _selectedCategory!,
              service: _selectedService!,
              serviceAreas: _selectedAreas,
              position: _selectedPosition ??
                  LatLng(5.3600, -4.0083), // Coordonnées par défaut Abidjan
              address: _selectedAddress ?? 'Abidjan',
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre de l'étape
            const Text(
              'Informations de base',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Remplissez ces informations essentielles pour commencer',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 32),

            // Formulaire
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Nom complet
                    _buildTextField(
                      controller: _nameController,
                      label: 'Nom complet *',
                      hint: 'Votre nom complet',
                      prefixIcon: Icons.person,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le nom complet est requis';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Téléphone
                    _buildTextField(
                      controller: _phoneController,
                      label: 'Téléphone *',
                      hint: 'Ex: +225 07 XX XX XX XX',
                      prefixIcon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Le téléphone est requis';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Email (optionnel)
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email (optionnel)',
                      hint: 'Si vous avez un email',
                      prefixIcon: Icons.email,
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
                      validator: (value) => value == null
                          ? 'Veuillez sélectionner votre catégorie'
                          : null,
                    ),
                    const SizedBox(height: 24),

                    // Service spécifique
                    _buildDropdown(
                      label: 'Votre service *',
                      value: _selectedService != null &&
                              _services
                                  .any((s) => s.idservice == _selectedService)
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
                      validator: (value) => value == null
                          ? 'Veuillez sélectionner votre service'
                          : null,
                    ),
                    const SizedBox(height: 24),

                    // Zones de service
                    const Text(
                      'Où travaillez-vous ? *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF374151),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _availableAreas.map((zone) {
                        final isSelected = _selectedAreas.contains(zone);
                        return FilterChip(
                          label: Text(zone),
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
                          selectedColor:
                              const Color(0xFF4CAF50).withOpacity(0.3),
                          checkmarkColor: const Color(0xFF4CAF50),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),

                    // Position exacte
                    const Text(
                      'Votre position exacte *',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF374151),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          if (_selectedPosition != null) ...[
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.red),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _selectedAddress ?? 'Position sélectionnée',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedPosition = null;
                                      _selectedAddress = '';
                                    });
                                  },
                                  icon: const Icon(Icons.close,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Lat: ${_selectedPosition!.latitude.toStringAsFixed(6)}, Lng: ${_selectedPosition!.longitude.toStringAsFixed(6)}',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[600]),
                            ),
                          ] else ...[
                            Row(
                              children: [
                                const Icon(Icons.location_off,
                                    color: Colors.grey),
                                const SizedBox(width: 8),
                                const Expanded(
                                  child: Text(
                                    'Position optionnelle - utilisez votre adresse',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: _getCurrentLocation,
                              icon: const Icon(Icons.edit_location),
                              label: const Text('Entrer mon adresse'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Note informative
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Profil de base créé ! Vous pourrez le compléter plus tard pour être vérifié.',
                              style: TextStyle(
                                  fontSize: 13, color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bouton de validation
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _validateAndSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Continuer',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🎯 CHAMP DE TEXTE
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
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  // 🎯 DROPDOWN
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
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }
}
