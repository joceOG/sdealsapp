import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SellerPersonalInfoStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function(Map<String, dynamic>) updateFormData;

  const SellerPersonalInfoStep({
    Key? key,
    required this.formData,
    required this.updateFormData,
  }) : super(key: key);

  @override
  _SellerPersonalInfoStepState createState() => _SellerPersonalInfoStepState();
}

class _SellerPersonalInfoStepState extends State<SellerPersonalInfoStep> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  DateTime? _selectedDate;
  String? _selectedGender;
  XFile? _profileImage;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    // Pré-remplir avec les données existantes si disponibles
    if (widget.formData.containsKey('fullName')) {
      _fullNameController.text = widget.formData['fullName'];
    }
    if (widget.formData.containsKey('phone')) {
      _phoneController.text = widget.formData['phone'];
    }
    if (widget.formData.containsKey('email')) {
      _emailController.text = widget.formData['email'];
    }
    if (widget.formData.containsKey('password')) {
      _passwordController.text = widget.formData['password'];
      _confirmPasswordController.text = widget.formData['password'];
    }
    if (widget.formData.containsKey('birthDate')) {
      _selectedDate = widget.formData['birthDate'];
    }
    if (widget.formData.containsKey('gender')) {
      _selectedGender = widget.formData['gender'];
    }
    if (widget.formData.containsKey('profileImagePath')) {
      _profileImage = XFile(widget.formData['profileImagePath']);
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _profileImage = image;
      });
      
      // Mise à jour des données du formulaire
      widget.updateFormData({
        'profileImagePath': image.path,
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().subtract(const Duration(days: 365 * 18)), // 18 ans par défaut
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.amber.shade700,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      
      widget.updateFormData({
        'birthDate': pickedDate,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        // Sauvegarde automatique à chaque changement
        if (_formKey.currentState!.validate()) {
          widget.updateFormData({
            'fullName': _fullNameController.text,
            'phone': _phoneController.text,
            'email': _emailController.text,
            'password': _passwordController.text,
            'gender': _selectedGender,
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: _profileImage != null
                        ? FileImage(File(_profileImage!.path))
                        : null,
                    child: _profileImage == null
                        ? Icon(
                            Icons.person_add,
                            size: 50,
                            color: Colors.grey.shade400,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Photo de profil (obligatoire)',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _fullNameController,
            decoration: const InputDecoration(
              labelText: 'Nom complet *',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Veuillez entrer votre nom complet';
              }
              if (value.trim().length < 3) {
                return 'Le nom doit contenir au moins 3 caractères';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Numéro de téléphone *',
              prefixIcon: Icon(Icons.phone),
              border: OutlineInputBorder(),
              hintText: 'Ex: 07 07 07 07 07',
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre numéro de téléphone';
              }
              if (!RegExp(r'^\d{10}$').hasMatch(value.replaceAll(RegExp(r'\D'), ''))) {
                return 'Numéro de téléphone invalide';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 8.0),
            child: Text(
              'Une vérification par SMS sera envoyée à ce numéro',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Adresse email *',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
              hintText: 'Ex: votre.email@example.com',
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer votre adresse email';
              }
              if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                return 'Adresse email invalide';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 8.0),
            child: Text(
              'Un email de confirmation sera envoyé à cette adresse',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blue.shade700,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Mot de passe *',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              border: const OutlineInputBorder(),
            ),
            obscureText: _obscurePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un mot de passe';
              }
              if (value.length < 8) {
                return 'Le mot de passe doit contenir au moins 8 caractères';
              }
              if (!RegExp(r'[A-Z]').hasMatch(value)) {
                return 'Le mot de passe doit contenir au moins une majuscule';
              }
              if (!RegExp(r'[0-9]').hasMatch(value)) {
                return 'Le mot de passe doit contenir au moins un chiffre';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirmer le mot de passe *',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              border: const OutlineInputBorder(),
            ),
            obscureText: _obscureConfirmPassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez confirmer votre mot de passe';
              }
              if (value != _passwordController.text) {
                return 'Les mots de passe ne correspondent pas';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Date de naissance (optionnel)',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => _selectDate(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.grey),
                  const SizedBox(width: 12),
                  Text(
                    _selectedDate != null
                        ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                        : 'Sélectionner une date',
                    style: TextStyle(
                      color: _selectedDate != null ? Colors.black : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Genre (optionnel)',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildGenderOption('Homme', 'male', Icons.male),
              const SizedBox(width: 16),
              _buildGenderOption('Femme', 'female', Icons.female),
              const SizedBox(width: 16),
              _buildGenderOption('Autre', 'other', Icons.person_outline),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String label, String value, IconData icon) {
    final bool isSelected = _selectedGender == value;
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedGender = value;
        });
        widget.updateFormData({
          'gender': value,
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.amber.shade700 : Colors.grey.shade400,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.amber.shade700 : Colors.grey.shade600,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.amber.shade700 : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
