import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SellerShopInfoStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function(Map<String, dynamic>) updateFormData;

  const SellerShopInfoStep({
    Key? key,
    required this.formData,
    required this.updateFormData,
  }) : super(key: key);

  @override
  _SellerShopInfoStepState createState() => _SellerShopInfoStepState();
}

class _SellerShopInfoStepState extends State<SellerShopInfoStep> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _shopDescriptionController = TextEditingController();
  
  String? _selectedBusinessType;
  final List<String> _businessTypes = ['Particulier', 'Entreprise', 'Auto-entrepreneur'];
  
  final List<String> _availableCategories = [
    'Mode', 'Électronique', 'Beauté', 'Maison', 'Informatique', 'Sports & Loisirs', 
    'Santé', 'Alimentation', 'Artisanat', 'Livres', 'Jouets', 'Animaux', 'Automobile'
  ];
  List<String> _selectedCategories = [];
  
  XFile? _shopLogo;
  int _maxDescriptionLength = 500;

  @override
  void initState() {
    super.initState();
    // Pré-remplir avec les données existantes si disponibles
    if (widget.formData.containsKey('shopName')) {
      _shopNameController.text = widget.formData['shopName'];
    }
    if (widget.formData.containsKey('shopDescription')) {
      _shopDescriptionController.text = widget.formData['shopDescription'];
    }
    if (widget.formData.containsKey('businessType')) {
      _selectedBusinessType = widget.formData['businessType'];
    }
    if (widget.formData.containsKey('shopCategories') && widget.formData['shopCategories'] is List) {
      _selectedCategories = List<String>.from(widget.formData['shopCategories']);
    } else if (widget.formData.containsKey('categories') && widget.formData['categories'] is List) {
      // Récupérer depuis la sélection précédente dans la page d'enregistrement
      _selectedCategories = List<String>.from(widget.formData['categories']);
    }
    if (widget.formData.containsKey('shopLogoPath')) {
      _shopLogo = XFile(widget.formData['shopLogoPath']);
    }
  }

  @override
  void dispose() {
    _shopNameController.dispose();
    _shopDescriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickLogo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _shopLogo = image;
      });
      
      // Mise à jour des données du formulaire
      widget.updateFormData({
        'shopLogoPath': image.path,
      });
    }
  }

  void _toggleCategory(String category) {
    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });
    
    widget.updateFormData({
      'shopCategories': _selectedCategories,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        // Sauvegarde automatique à chaque changement
        if (_formKey.currentState!.validate()) {
          widget.updateFormData({
            'shopName': _shopNameController.text,
            'shopDescription': _shopDescriptionController.text,
            'businessType': _selectedBusinessType,
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _shopNameController,
            decoration: const InputDecoration(
              labelText: 'Nom de la boutique *',
              prefixIcon: Icon(Icons.store),
              border: OutlineInputBorder(),
              hintText: 'Ex: Chez Mamadou Fashion',
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Veuillez entrer un nom pour votre boutique';
              }
              if (value.trim().length < 3) {
                return 'Le nom doit contenir au moins 3 caractères';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 8.0),
            child: Text(
              'Ce nom sera visible par tous les clients',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Type de commerce *',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: _businessTypes.map((type) {
              return Expanded(
                child: _buildBusinessTypeOption(type),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickLogo,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                      image: _shopLogo != null
                          ? DecorationImage(
                              image: FileImage(File(_shopLogo!.path)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _shopLogo == null
                        ? Icon(
                            Icons.add_photo_alternate,
                            size: 40,
                            color: Colors.grey.shade400,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Logo de la boutique (optionnel)',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  'Format carré recommandé',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Catégories de produits *',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Sélectionnez au moins une catégorie de produits que vous vendez',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _availableCategories.map((category) {
              final isSelected = _selectedCategories.contains(category);
              return ChoiceChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (_) => _toggleCategory(category),
                backgroundColor: Colors.grey.shade100,
                selectedColor: Colors.amber.shade100,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.amber.shade800 : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected ? Colors.amber.shade700 : Colors.grey.shade300,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Description de la boutique *',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _shopDescriptionController,
            decoration: InputDecoration(
              hintText: 'Décrivez votre boutique et vos produits...',
              border: const OutlineInputBorder(),
              counterText: '${_shopDescriptionController.text.length}/$_maxDescriptionLength caractères',
            ),
            maxLines: 5,
            maxLength: _maxDescriptionLength,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Veuillez entrer une description pour votre boutique';
              }
              if (value.trim().length < 50) {
                return 'La description doit contenir au moins 50 caractères';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                // Pour mettre à jour le compteur de caractères
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 8.0),
            child: Text(
              'Décrivez votre boutique, vos produits et votre expertise',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessTypeOption(String type) {
    final bool isSelected = _selectedBusinessType == type;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedBusinessType = type;
          });
          widget.updateFormData({
            'businessType': type,
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.amber.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? Colors.amber.shade700 : Colors.grey.shade400,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Center(
            child: Text(
              type,
              style: TextStyle(
                color: isSelected ? Colors.amber.shade700 : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
