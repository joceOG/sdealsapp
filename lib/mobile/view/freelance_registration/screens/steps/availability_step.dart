import 'package:flutter/material.dart';

class AvailabilityStep extends StatefulWidget {
  final Map<String, dynamic> formData;

  const AvailabilityStep({Key? key, required this.formData}) : super(key: key);

  @override
  _AvailabilityStepState createState() => _AvailabilityStepState();
}

class _AvailabilityStepState extends State<AvailabilityStep> {
  String? _selectedStatus;
  String? _selectedHours;
  String? _selectedTimeZone;
  final Map<String, String> _selectedLanguages = {};

  // Options pour le statut
  final List<String> _statusOptions = ['Disponible', 'Occupé', 'En pause'];

  // Options pour les heures de travail
  final List<String> _hoursOptions = [
    'Moins de 10h par semaine',
    '10-20h par semaine',
    '20-30h par semaine',
    '30-40h par semaine',
    'Plus de 40h par semaine'
  ];

  // Options pour les fuseaux horaires
  final List<String> _timeZones = [
    'GMT+0 (Dakar)',
    'GMT+1 (Paris)',
    'GMT+2 (Le Caire)',
    'GMT-5 (New York)',
    'GMT-8 (Los Angeles)',
    'GMT+3 (Moscou)',
    'GMT+5:30 (New Delhi)',
  ];

  // Options pour les langues
  final List<Map<String, dynamic>> _languages = [
    {'name': 'Français', 'levels': ['Débutant', 'Intermédiaire', 'Avancé', 'Natif']},
    {'name': 'Anglais', 'levels': ['Débutant', 'Intermédiaire', 'Avancé', 'Natif']},
    {'name': 'Espagnol', 'levels': ['Débutant', 'Intermédiaire', 'Avancé', 'Natif']},
    {'name': 'Arabe', 'levels': ['Débutant', 'Intermédiaire', 'Avancé', 'Natif']},
    {'name': 'Wolof', 'levels': ['Débutant', 'Intermédiaire', 'Avancé', 'Natif']},
    {'name': 'Portugais', 'levels': ['Débutant', 'Intermédiaire', 'Avancé', 'Natif']},
  ];

  @override
  void initState() {
    super.initState();
    // Initialiser avec les données existantes si disponibles
    _selectedStatus = widget.formData['availabilityStatus'] ?? 'Disponible';
    _selectedHours = widget.formData['workHours'];
    _selectedTimeZone = widget.formData['timeZone'] ?? 'GMT+0 (Dakar)';
    
    if (widget.formData['languages'] != null) {
      _selectedLanguages.addAll(
          Map<String, String>.from(widget.formData['languages']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🎯 Disponibilité',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          
          // Statut de disponibilité
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Statut'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _statusOptions.map((status) {
                  return ChoiceChip(
                    label: Text(status),
                    selected: _selectedStatus == status,
                    selectedColor: Colors.green.shade100,
                    onSelected: (selected) {
                      setState(() {
                        _selectedStatus = selected ? status : null;
                        widget.formData['availabilityStatus'] = _selectedStatus;
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Heures de travail par semaine
          DropdownButtonFormField<String>(
            value: _selectedHours,
            decoration: const InputDecoration(
              labelText: 'Heures de travail *',
              border: OutlineInputBorder(),
            ),
            items: _hoursOptions.map((hours) {
              return DropdownMenuItem(
                value: hours,
                child: Text(hours),
              );
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez sélectionner vos heures de disponibilité';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _selectedHours = value;
                widget.formData['workHours'] = value;
              });
            },
          ),
          const SizedBox(height: 16),
          
          // Fuseau horaire
          DropdownButtonFormField<String>(
            value: _selectedTimeZone,
            decoration: const InputDecoration(
              labelText: 'Fuseau horaire *',
              border: OutlineInputBorder(),
            ),
            items: _timeZones.map((timezone) {
              return DropdownMenuItem(
                value: timezone,
                child: Text(timezone),
              );
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez sélectionner votre fuseau horaire';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _selectedTimeZone = value;
                widget.formData['timeZone'] = value;
              });
            },
          ),
          const SizedBox(height: 24),
          
          // Langues parlées
          const Text(
            'Langues parlées',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          
          // Liste des langues avec niveau de maîtrise
          ...List.generate(_languages.length, (index) {
            final language = _languages[index];
            final String languageName = language['name'];
            final List<String> levels = language['levels'];
            final selectedLevel = _selectedLanguages[languageName];
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      languageName,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 8),
                    if (selectedLevel != null)
                      Chip(
                        label: Text(selectedLevel),
                        backgroundColor: Colors.green.shade100,
                        deleteIconColor: Colors.green.shade700,
                        onDeleted: () {
                          setState(() {
                            _selectedLanguages.remove(languageName);
                            widget.formData['languages'] = _selectedLanguages;
                          });
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                if (selectedLevel == null)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: levels.map((level) {
                      return ActionChip(
                        label: Text(level),
                        onPressed: () {
                          setState(() {
                            _selectedLanguages[languageName] = level;
                            widget.formData['languages'] = _selectedLanguages;
                          });
                        },
                      );
                    }).toList(),
                  ),
                const SizedBox(height: 8),
                const Divider(),
              ],
            );
          }),
          
          // Message d'instruction pour les langues
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue.shade700,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Sélectionnez au moins une langue avec votre niveau de maîtrise. La maîtrise du français ou de l\'anglais est fortement recommandée.',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
