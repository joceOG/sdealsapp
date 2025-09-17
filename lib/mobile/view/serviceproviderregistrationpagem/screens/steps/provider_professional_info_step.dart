import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProviderProfessionalInfoStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function(Map<String, dynamic>) onDataChanged;

  const ProviderProfessionalInfoStep({
    Key? key,
    required this.formData,
    required this.onDataChanged,
  }) : super(key: key);

  @override
  State<ProviderProfessionalInfoStep> createState() =>
      _ProviderProfessionalInfoStepState();
}

class _ProviderProfessionalInfoStepState
    extends State<ProviderProfessionalInfoStep> {
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _yearsExperienceController =
      TextEditingController();
  final TextEditingController _serviceDescriptionController =
      TextEditingController();
  final TextEditingController _serviceRadiusController = TextEditingController();

  String? _selectedCategory;
  List<String> _selectedSpecialties = [];
  List<String> _selectedAreas = [];
  LatLng? _selectedLocation;

  // Simulation des données de l'API
  final List<Map<String, dynamic>> _categories = [
    {
      'name': 'Plombier',
      'specialties': [
        'Installation sanitaire',
        'Réparation de fuites',
        'Débouchage',
        'Chauffe-eau',
        'Robinetterie'
      ]
    },
    {
      'name': 'Électricien',
      'specialties': [
        'Installation électrique',
        'Dépannage',
        'Câblage',
        'Tableau électrique',
        'Éclairage'
      ]
    },
    {
      'name': 'Menuisier',
      'specialties': [
        'Meubles sur mesure',
        'Pose de parquet',
        'Réparation',
        'Aménagement',
        'Portes et fenêtres'
      ]
    },
    {
      'name': 'Peintre',
      'specialties': [
        'Intérieur',
        'Extérieur',
        'Décoration',
        'Revêtement mural',
        'Enduit'
      ]
    },
    {
      'name': 'Maçon',
      'specialties': [
        'Construction',
        'Rénovation',
        'Carrelage',
        'Plâtrerie',
        'Béton'
      ]
    },
    {
      'name': 'Jardinier',
      'specialties': [
        'Entretien',
        'Aménagement paysager',
        'Taille',
        'Plantation',
        'Gazon'
      ]
    },
    {
      'name': 'Serrurier',
      'specialties': [
        'Ouverture de porte',
        'Installation de serrures',
        'Blindage',
        'Dépannage d\'urgence',
        'Coffre-fort'
      ]
    },
    {
      'name': 'Chauffagiste',
      'specialties': [
        'Installation',
        'Entretien',
        'Dépannage',
        'Climatisation',
        'Pompe à chaleur'
      ]
    }
  ];

  // Zones disponibles (à remplacer par des données réelles de l'API)
  final List<String> _availableAreas = [
    'Abidjan', 'Abobo', 'Adjamé', 'Attécoubé', 'Cocody',
    'Koumassi', 'Marcory', 'Plateau', 'Port-Bouët', 'Treichville',
    'Yopougon', 'Bingerville', 'Yamoussoukro', 'Bouaké', 'Daloa',
    'San Pedro', 'Korhogo', 'Anyama', 'Divo'
  ];

  List<String> _currentSpecialties = [];

  @override
  void initState() {
    super.initState();
    _initializeFormValues();
  }

  void _initializeFormValues() {
    _businessNameController.text = widget.formData['businessName'] ?? '';
    _yearsExperienceController.text =
        widget.formData['yearsOfExperience']?.toString() ?? '';
    _serviceDescriptionController.text =
        widget.formData['serviceDescription'] ?? '';
    _serviceRadiusController.text =
        widget.formData['serviceRadius']?.toString() ?? '';
    _selectedCategory = widget.formData['category'];
    _selectedSpecialties =
        List<String>.from(widget.formData['specialties'] ?? []);
    _selectedAreas = List<String>.from(widget.formData['serviceAreas'] ?? []);
    
    // Initialiser les spécialités en fonction de la catégorie
    if (_selectedCategory != null) {
      _updateSpecialties(_selectedCategory!);
    }
    
    // Initialiser la location
    if (widget.formData['location'] != null) {
      _selectedLocation = LatLng(
        widget.formData['location']['latitude'],
        widget.formData['location']['longitude'],
      );
    }
  }

  void _updateSpecialties(String category) {
    final categoryData = _categories.firstWhere(
        (cat) => cat['name'] == category,
        orElse: () => {'name': '', 'specialties': []});
        
    setState(() {
      _currentSpecialties = List<String>.from(categoryData['specialties']);
    });
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _yearsExperienceController.dispose();
    _serviceDescriptionController.dispose();
    _serviceRadiusController.dispose();
    super.dispose();
  }

  void _updateFormData() {
    Map<String, dynamic> updatedData = {
      'businessName': _businessNameController.text,
      'category': _selectedCategory,
      'specialties': _selectedSpecialties,
      'yearsOfExperience': int.tryParse(_yearsExperienceController.text) ?? 0,
      'serviceDescription': _serviceDescriptionController.text,
      'serviceAreas': _selectedAreas,
      'serviceRadius': double.tryParse(_serviceRadiusController.text) ?? 0.0,
      'location': _selectedLocation != null
          ? {
              'latitude': _selectedLocation!.latitude,
              'longitude': _selectedLocation!.longitude,
            }
          : null,
    };
    widget.onDataChanged(updatedData);
  }

  void _showMapSelector() async {
    // Ici, vous pourriez ouvrir une page de carte pour sélectionner l'emplacement précis
    // Pour cet exemple, nous simulons la sélection d'un emplacement
    setState(() {
      // Coordonnées d'Abidjan comme exemple
      _selectedLocation = const LatLng(5.3599517, -4.0082563);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Localisation sélectionnée'),
        backgroundColor: Colors.green,
      ),
    );
    
    _updateFormData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informations professionnelles',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Nom de l'entreprise/Activité
          TextFormField(
            controller: _businessNameController,
            decoration: const InputDecoration(
              labelText: 'Nom de l\'entreprise/Activité *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.business),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer le nom de votre entreprise ou activité';
              }
              return null;
            },
            onChanged: (value) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Catégorie de métier
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Catégorie de métier *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.category),
            ),
            value: _selectedCategory,
            items: _categories.map((category) {
              return DropdownMenuItem<String>(
                value: category['name'],
                child: Text(category['name']),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
                _selectedSpecialties = []; // Réinitialiser les spécialités
                if (value != null) {
                  _updateSpecialties(value);
                }
              });
              _updateFormData();
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez sélectionner une catégorie';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Spécialités
          if (_selectedCategory != null && _currentSpecialties.isNotEmpty) ...[
            const Text(
              'Spécialités (sélectionnez une ou plusieurs)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _currentSpecialties.map((specialty) {
                final isSelected = _selectedSpecialties.contains(specialty);
                return FilterChip(
                  label: Text(specialty),
                  selected: isSelected,
                  selectedColor: Colors.orange.withOpacity(0.3),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedSpecialties.add(specialty);
                      } else {
                        _selectedSpecialties.remove(specialty);
                      }
                    });
                    _updateFormData();
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],

          // Années d'expérience
          TextFormField(
            controller: _yearsExperienceController,
            decoration: const InputDecoration(
              labelText: 'Années d\'expérience *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.timeline),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez indiquer vos années d\'expérience';
              }
              return null;
            },
            onChanged: (value) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Description des services
          TextFormField(
            controller: _serviceDescriptionController,
            decoration: const InputDecoration(
              labelText: 'Description des services',
              hintText: 'Décrivez en détail les services que vous proposez',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.description),
            ),
            maxLines: 3,
            maxLength: 500,
            onChanged: (value) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Zone d'intervention (villes/quartiers)
          const Text(
            'Zones d\'intervention',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: _availableAreas.map((area) {
              final isSelected = _selectedAreas.contains(area);
              return FilterChip(
                label: Text(area),
                selected: isSelected,
                selectedColor: Colors.green.withOpacity(0.3),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedAreas.add(area);
                    } else {
                      _selectedAreas.remove(area);
                    }
                  });
                  _updateFormData();
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // Rayon d'intervention
          TextFormField(
            controller: _serviceRadiusController,
            decoration: const InputDecoration(
              labelText: 'Rayon d\'intervention (km)',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.adjust),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) => _updateFormData(),
          ),
          const SizedBox(height: 20),

          // Localisation précise
          ElevatedButton.icon(
            onPressed: _showMapSelector,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              minimumSize: const Size(double.infinity, 50),
            ),
            icon: const Icon(Icons.location_on, color: Colors.white),
            label: Text(
              _selectedLocation != null
                  ? 'Localisation sélectionnée ✓'
                  : 'Sélectionner ma localisation précise',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),

          if (_selectedLocation != null)
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _selectedLocation!,
                  zoom: 14,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('selected_location'),
                    position: _selectedLocation!,
                    infoWindow: const InfoWindow(title: 'Votre emplacement'),
                  ),
                },
              ),
            ),
        ],
      ),
    );
  }
}
