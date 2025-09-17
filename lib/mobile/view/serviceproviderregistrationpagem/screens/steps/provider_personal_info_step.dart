import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProviderPersonalInfoStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function(Map<String, dynamic>) onDataChanged;

  const ProviderPersonalInfoStep({
    Key? key,
    required this.formData,
    required this.onDataChanged,
  }) : super(key: key);

  @override
  State<ProviderPersonalInfoStep> createState() => _ProviderPersonalInfoStepState();
}

class _ProviderPersonalInfoStepState extends State<ProviderPersonalInfoStep> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  DateTime? _selectedDate;
  String? _selectedGender;
  File? _profileImage;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _initializeFormValues();
  }

  void _initializeFormValues() {
    _nameController.text = widget.formData['fullName'] ?? '';
    _phoneController.text = widget.formData['phone'] ?? '';
    _emailController.text = widget.formData['email'] ?? '';
    _passwordController.text = widget.formData['password'] ?? '';
    _selectedDate = widget.formData['birthDate'];
    _selectedGender = widget.formData['gender'] ?? 'Homme'; // Valeur par défaut
    
    if (widget.formData['profileImage'] != null) {
      _profileImage = File(widget.formData['profileImage']);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 18)), // Minimum 18 ans
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      
      _updateFormData();
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
      
      _updateFormData();
    }
  }

  void _updateFormData() {
    Map<String, dynamic> updatedData = {
      'fullName': _nameController.text,
      'phone': _phoneController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'birthDate': _selectedDate,
      'gender': _selectedGender,
      'profileImage': _profileImage?.path,
    };
    
    widget.onDataChanged(updatedData);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informations personnelles',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Photo de profil
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                    child: _profileImage == null
                        ? const Icon(Icons.add_a_photo, size: 40, color: Colors.grey)
                        : null,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Photo de profil *',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Nom complet
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Nom complet *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre nom complet';
              }
              return null;
            },
            onChanged: (value) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Téléphone
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Téléphone *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
              hintText: 'Ex: +225 07 XX XX XX XX',
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre numéro de téléphone';
              }
              return null;
            },
            onChanged: (value) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Email
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre email';
              }
              if (!value.contains('@') || !value.contains('.')) {
                return 'Veuillez entrer un email valide';
              }
              return null;
            },
            onChanged: (value) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Mot de passe
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Mot de passe *',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            obscureText: _obscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un mot de passe';
              }
              if (value.length < 6) {
                return 'Le mot de passe doit contenir au moins 6 caractères';
              }
              return null;
            },
            onChanged: (value) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Confirmation du mot de passe
          TextFormField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirmer le mot de passe *',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
            ),
            obscureText: _obscureConfirmPassword,
            validator: (value) {
              if (value != _passwordController.text) {
                return 'Les mots de passe ne correspondent pas';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Date de naissance
          InkWell(
            onTap: () => _selectDate(context),
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Date de naissance',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
              child: Text(
                _selectedDate == null
                    ? 'Sélectionner une date'
                    : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                style: TextStyle(
                  color: _selectedDate == null ? Colors.grey : Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Genre
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Genre',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.people),
            ),
            value: _selectedGender ?? 'Homme', // Assure une valeur valide
            items: const [
              DropdownMenuItem(value: 'Homme', child: Text('Homme')),
              DropdownMenuItem(value: 'Femme', child: Text('Femme')),
              DropdownMenuItem(value: 'Autre', child: Text('Autre')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedGender = value;
              });
              _updateFormData();
            },
            validator: (value) => value == null ? 'Veuillez sélectionner votre genre' : null,
          ),
          const SizedBox(height: 30),

          // Note sur la vérification
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: const Row(
              children: [
                Icon(Icons.info, color: Colors.orange),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Un code de vérification sera envoyé à votre numéro de téléphone et à votre email.',
                    style: TextStyle(fontSize: 13, color: Colors.black87),
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
