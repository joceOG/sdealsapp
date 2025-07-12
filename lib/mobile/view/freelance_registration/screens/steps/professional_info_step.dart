import 'package:flutter/material.dart';

class ProfessionalInfoStep extends StatefulWidget {
  final Map<String, dynamic> formData;

  const ProfessionalInfoStep({Key? key, required this.formData}) : super(key: key);

  @override
  _ProfessionalInfoStepState createState() => _ProfessionalInfoStepState();
}

class _ProfessionalInfoStepState extends State<ProfessionalInfoStep> {
  final TextEditingController _skillsController = TextEditingController();
  String? _selectedExperienceLevel;
  String? _selectedCategory;
  final Set<String> _selectedSkills = {};

  // Catégories disponibles
  final List<String> _categories = [
    'Développement',
    'Design',
    'Marketing',
    'Rédaction',
    'Traduction',
    'Photo',
    'Audio',
    'Vidéo',
    'Conseil',
    'Autre'
  ];

  // Niveaux d'expérience
  final List<String> _experienceLevels = [
    'Débutant',
    'Intermédiaire',
    'Expert'
  ];

  // Compétences suggérées par catégorie
  final Map<String, List<String>> _categorySkills = {
    'Développement': ['HTML', 'CSS', 'JavaScript', 'Python', 'Java', 'PHP', 'React', 'Flutter', 'NodeJS'],
    'Design': ['Photoshop', 'Illustrator', 'Figma', 'UI/UX', 'Logo Design', 'Branding'],
    'Marketing': ['SEO', 'SEM', 'Social Media', 'Content Marketing', 'Email Marketing', 'Analytics'],
    'Rédaction': ['Articles', 'Blog', 'Copywriting', 'SEO Writing', 'Storytelling'],
    'Traduction': ['Anglais', 'Français', 'Espagnol', 'Arabe', 'Wolof'],
    'Photo': ['Portrait', 'Événementiel', 'Produit', 'Retouche', 'Photojournalisme'],
    'Audio': ['Mixage', 'Mastering', 'Voix Off', 'Podcast', 'Sound Design'],
    'Vidéo': ['Montage', 'Animation', 'Motion Design', 'VFX', 'YouTube'],
    'Conseil': ['Stratégie', 'Business Plan', 'Gestion de projet', 'Coaching'],
    'Autre': ['Excel', 'PowerPoint', 'Data Entry', 'Support Client', 'Testing']
  };

  @override
  void initState() {
    super.initState();
    // Initialiser avec les données existantes si disponibles
    _selectedCategory = widget.formData['mainCategory'];
    _selectedExperienceLevel = widget.formData['experienceLevel'];
    
    if (widget.formData['skills'] != null) {
      _selectedSkills.addAll(Set<String>.from(widget.formData['skills']));
    }
    
    // Si catégorie pré-sélectionnée depuis l'étape précédente
    if (widget.formData['selectedCategories'] != null && 
        widget.formData['selectedCategories'].isNotEmpty &&
        _selectedCategory == null) {
      _selectedCategory = widget.formData['selectedCategories'].first;
      widget.formData['mainCategory'] = _selectedCategory;
    }
  }

  @override
  void dispose() {
    _skillsController.dispose();
    super.dispose();
  }

  void _addSkill() {
    if (_skillsController.text.isNotEmpty) {
      setState(() {
        _selectedSkills.add(_skillsController.text);
        widget.formData['skills'] = _selectedSkills.toList();
        _skillsController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '💼 Profil professionnel',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          
          // Titre professionnel
          TextFormField(
            initialValue: widget.formData['professionalTitle'] ?? '',
            decoration: const InputDecoration(
              labelText: 'Titre professionnel *',
              hintText: 'Ex: Développeur Full-Stack, Designer UI/UX',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ est obligatoire';
              }
              return null;
            },
            onChanged: (value) {
              widget.formData['professionalTitle'] = value;
            },
          ),
          const SizedBox(height: 16),
          
          // Catégorie principale
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: const InputDecoration(
              labelText: 'Catégorie principale *',
              border: OutlineInputBorder(),
            ),
            items: _categories.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category),
              );
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez sélectionner une catégorie';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
                widget.formData['mainCategory'] = value;
              });
            },
          ),
          const SizedBox(height: 16),
          
          // Niveau d'expérience
          DropdownButtonFormField<String>(
            value: _selectedExperienceLevel,
            decoration: const InputDecoration(
              labelText: 'Niveau d\'expérience *',
              border: OutlineInputBorder(),
            ),
            items: _experienceLevels.map((level) {
              return DropdownMenuItem(
                value: level,
                child: Text(level),
              );
            }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez sélectionner un niveau d\'expérience';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _selectedExperienceLevel = value;
                widget.formData['experienceLevel'] = value;
              });
            },
          ),
          const SizedBox(height: 16),
          
          // Compétences
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Compétences',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _skillsController,
                      decoration: const InputDecoration(
                        hintText: 'Ajouter une compétence',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _addSkill,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(14),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              if (_selectedCategory != null && _categorySkills.containsKey(_selectedCategory))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Compétences suggérées pour $_selectedCategory:',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _categorySkills[_selectedCategory]!.map((skill) {
                        final isSelected = _selectedSkills.contains(skill);
                        return ActionChip(
                          label: Text(skill),
                          backgroundColor: isSelected ? Colors.green.shade100 : null,
                          side: BorderSide(
                            color: isSelected ? Colors.green.shade700 : Colors.grey.shade300,
                          ),
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.green.shade700 : null,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isSelected) {
                                _selectedSkills.remove(skill);
                              } else {
                                _selectedSkills.add(skill);
                              }
                              widget.formData['skills'] = _selectedSkills.toList();
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              
              const SizedBox(height: 16),
              Text(
                'Compétences sélectionnées:',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _selectedSkills.isEmpty
                    ? [
                        Chip(
                          label: const Text('Aucune compétence'),
                          backgroundColor: Colors.grey.shade200,
                        )
                      ]
                    : _selectedSkills.map((skill) {
                        return Chip(
                          label: Text(skill),
                          backgroundColor: Colors.green.shade100,
                          deleteIconColor: Colors.green.shade700,
                          onDeleted: () {
                            setState(() {
                              _selectedSkills.remove(skill);
                              widget.formData['skills'] = _selectedSkills.toList();
                            });
                          },
                        );
                      }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // URL du portfolio
          TextFormField(
            initialValue: widget.formData['portfolioUrl'] ?? '',
            decoration: const InputDecoration(
              labelText: 'URL du Portfolio (optionnel)',
              hintText: 'https://votre-portfolio.com',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.url,
            onChanged: (value) {
              widget.formData['portfolioUrl'] = value;
            },
          ),
          const SizedBox(height: 16),
          
          // Description/Bio
          TextFormField(
            initialValue: widget.formData['bio'] ?? '',
            decoration: const InputDecoration(
              labelText: 'Description / Bio *',
              hintText: 'Présentez-vous en quelques lignes...',
              border: OutlineInputBorder(),
              helperText: 'Max. 500 caractères',
            ),
            maxLines: 4,
            maxLength: 500,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ est obligatoire';
              }
              return null;
            },
            onChanged: (value) {
              widget.formData['bio'] = value;
            },
          ),
        ],
      ),
    );
  }
}
