import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/prestataire_registration.dart';

// 🎯 ÉTAPE SÉLECTION DES SERVICES
class ServiceSelectionStep extends StatefulWidget {
  const ServiceSelectionStep({super.key});

  @override
  State<ServiceSelectionStep> createState() => _ServiceSelectionStepState();
}

class _ServiceSelectionStepState extends State<ServiceSelectionStep> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _competencesController = TextEditingController();

  List<String> _selectedCategories = [];
  List<String> _selectedServices = [];
  List<String> _competences = [];

  @override
  void dispose() {
    _descriptionController.dispose();
    _competencesController.dispose();
    super.dispose();
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
              'Sélection des services',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Choisissez les services que vous souhaitez proposer',
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
                    // Catégories
                    _buildSection(
                      title: 'Catégories *',
                      subtitle: 'Sélectionnez au moins une catégorie',
                      child: _buildCategoriesGrid(),
                    ),
                    const SizedBox(height: 32),

                    // Services
                    _buildSection(
                      title: 'Services *',
                      subtitle: 'Choisissez les services spécifiques',
                      child: _buildServicesGrid(),
                    ),
                    const SizedBox(height: 32),

                    // Description
                    _buildTextField(
                      controller: _descriptionController,
                      label: 'Description de vos services *',
                      hint:
                          'Décrivez vos services, votre expérience et vos spécialités...',
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'La description est requise';
                        }
                        if (value.length < 50) {
                          return 'La description doit contenir au moins 50 caractères';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Compétences
                    _buildTextField(
                      controller: _competencesController,
                      label: 'Compétences',
                      hint:
                          'Ajoutez vos compétences (séparées par des virgules)',
                      onChanged: (value) {
                        setState(() {
                          _competences = value
                              .split(',')
                              .map((e) => e.trim())
                              .where((e) => e.isNotEmpty)
                              .toList();
                        });
                      },
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

  // 🎯 SECTION
  Widget _buildSection({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
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
        const SizedBox(height: 16),
        child,
      ],
    );
  }

  // 🎯 GRILLE DES CATÉGORIES
  Widget _buildCategoriesGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: constraints.maxWidth > 800 ? 3 : 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
          ),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final category = _categories[index];
            final isSelected = _selectedCategories.contains(category['id']);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedCategories.remove(category['id']);
                  } else {
                    _selectedCategories.add(category['id']);
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF4CAF50).withOpacity(0.1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF4CAF50)
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    Icon(
                      category['icon'],
                      color: isSelected
                          ? const Color(0xFF4CAF50)
                          : Colors.grey.shade600,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        category['name'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFF374151),
                        ),
                      ),
                    ),
                    if (isSelected)
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.check_circle,
                          color: Color(0xFF4CAF50),
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // 🎯 GRILLE DES SERVICES
  Widget _buildServicesGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: constraints.maxWidth > 800 ? 2 : 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 4,
          ),
          itemCount: _services.length,
          itemBuilder: (context, index) {
            final service = _services[index];
            final isSelected = _selectedServices.contains(service['id']);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedServices.remove(service['id']);
                  } else {
                    _selectedServices.add(service['id']);
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF4CAF50).withOpacity(0.1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF4CAF50)
                        : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    Icon(
                      service['icon'],
                      color: isSelected
                          ? const Color(0xFF4CAF50)
                          : Colors.grey.shade600,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service['name'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? const Color(0xFF4CAF50)
                                  : const Color(0xFF374151),
                            ),
                          ),
                          Text(
                            service['description'],
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected
                                  ? const Color(0xFF4CAF50).withOpacity(0.8)
                                  : Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.check_circle,
                          color: Color(0xFF4CAF50),
                          size: 20,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // 🎯 CHAMP DE TEXTE
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
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
          maxLines: maxLines,
          validator: validator,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
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
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  // 🎯 VALIDATION ET SAUVEGARDE
  void _validateAndSave() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategories.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez sélectionner au moins une catégorie'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_selectedServices.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez sélectionner au moins un service'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      context.read<PrestataireRegistrationBloc>().add(
            SaveServiceSelection(
              categories: _selectedCategories,
              services: _selectedServices,
              description: _descriptionController.text,
              competences: _competences,
            ),
          );
    }
  }

  // 🎯 DONNÉES DES CATÉGORIES
  static final List<Map<String, dynamic>> _categories = [
    {
      'id': 'bricolage',
      'name': 'Bricolage',
      'icon': Icons.build,
    },
    {
      'id': 'menage',
      'name': 'Ménage',
      'icon': Icons.cleaning_services,
    },
    {
      'id': 'transport',
      'name': 'Transport',
      'icon': Icons.directions_car,
    },
    {
      'id': 'informatique',
      'name': 'Informatique',
      'icon': Icons.computer,
    },
    {
      'id': 'coaching',
      'name': 'Coaching',
      'icon': Icons.psychology,
    },
    {
      'id': 'musique',
      'name': 'Musique',
      'icon': Icons.music_note,
    },
  ];

  // 🎯 DONNÉES DES SERVICES
  static final List<Map<String, dynamic>> _services = [
    {
      'id': 'reparation_electromenager',
      'name': 'Réparation électroménager',
      'description': 'Réparation de tous types d\'appareils',
      'icon': Icons.build,
    },
    {
      'id': 'menage_ponctuel',
      'name': 'Ménage ponctuel',
      'description': 'Nettoyage ponctuel de votre domicile',
      'icon': Icons.cleaning_services,
    },
    {
      'id': 'transport_personnes',
      'name': 'Transport de personnes',
      'description': 'Transport sécurisé de personnes',
      'icon': Icons.directions_car,
    },
    {
      'id': 'depannage_informatique',
      'name': 'Dépannage informatique',
      'description': 'Résolution de problèmes informatiques',
      'icon': Icons.computer,
    },
    {
      'id': 'coaching_personnel',
      'name': 'Coaching personnel',
      'description': 'Accompagnement et développement personnel',
      'icon': Icons.psychology,
    },
    {
      'id': 'cours_musique',
      'name': 'Cours de musique',
      'description': 'Apprentissage d\'instruments de musique',
      'icon': Icons.music_note,
    },
  ];
}
