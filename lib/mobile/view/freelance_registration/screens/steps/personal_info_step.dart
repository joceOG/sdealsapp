import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PersonalInfoStep extends StatefulWidget {
  final Map<String, dynamic> formData;

  const PersonalInfoStep({Key? key, required this.formData}) : super(key: key);

  @override
  _PersonalInfoStepState createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends State<PersonalInfoStep> {
  final ImagePicker _picker = ImagePicker();
  String? _selectedGender;
  DateTime? _selectedDate;
  XFile? _profileImage;

  final List<String> _genders = ['Homme', 'Femme', 'Autre', 'Préfère ne pas préciser'];

  @override
  void initState() {
    super.initState();
    // Initialiser avec les données existantes si disponibles
    _selectedGender = widget.formData['gender'];
    _selectedDate = widget.formData['birthDate'];
    
    if (widget.formData['profileImagePath'] != null) {
      _profileImage = XFile(widget.formData['profileImagePath']);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1950),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.green.shade700,
            colorScheme: ColorScheme.light(primary: Colors.green.shade700),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.formData['birthDate'] = picked;
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 85,
    );
    
    if (pickedFile != null) {
      setState(() {
        _profileImage = pickedFile;
        widget.formData['profileImagePath'] = pickedFile.path;
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
            '📝 Informations personnelles',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          
          // Photo de profil
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(color: Colors.green.shade700, width: 2),
                      image: _profileImage != null
                          ? DecorationImage(
                              image: FileImage(File(_profileImage!.path)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _profileImage == null
                        ? Icon(
                            Icons.add_a_photo,
                            color: Colors.green.shade700,
                            size: 40,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Photo de profil',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                if (_profileImage == null)
                  const Text(
                    '(Obligatoire)',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Nom complet
          TextFormField(
            initialValue: widget.formData['fullName'] ?? '',
            decoration: const InputDecoration(
              labelText: 'Nom complet *',
              hintText: 'Prénom et Nom',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ est obligatoire';
              }
              return null;
            },
            onChanged: (value) {
              widget.formData['fullName'] = value;
            },
          ),
          const SizedBox(height: 16),
          
          // Téléphone
          TextFormField(
            initialValue: widget.formData['phone'] ?? '',
            decoration: const InputDecoration(
              labelText: 'Téléphone *',
              hintText: '+221 XX XXX XX XX',
              border: OutlineInputBorder(),
              helperText: 'Ce numéro sera vérifié par SMS',
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ est obligatoire';
              }
              // Ajoutez une validation de format de numéro de téléphone
              return null;
            },
            onChanged: (value) {
              widget.formData['phone'] = value;
            },
          ),
          const SizedBox(height: 16),
          
          // Email
          TextFormField(
            initialValue: widget.formData['email'] ?? '',
            decoration: const InputDecoration(
              labelText: 'Email *',
              hintText: 'votreemail@exemple.com',
              border: OutlineInputBorder(),
              helperText: 'Ce email sera vérifié',
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ est obligatoire';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Entrez une adresse email valide';
              }
              return null;
            },
            onChanged: (value) {
              widget.formData['email'] = value;
            },
          ),
          const SizedBox(height: 16),
          
          // Mot de passe
          TextFormField(
            initialValue: widget.formData['password'] ?? '',
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Mot de passe *',
              border: OutlineInputBorder(),
              helperText: 'Min. 8 caractères avec lettres et chiffres',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ est obligatoire';
              }
              if (value.length < 8) {
                return 'Le mot de passe doit contenir au moins 8 caractères';
              }
              if (!RegExp(r'(?=.*[A-Za-z])(?=.*\d)').hasMatch(value)) {
                return 'Le mot de passe doit contenir des lettres et des chiffres';
              }
              return null;
            },
            onChanged: (value) {
              widget.formData['password'] = value;
            },
          ),
          const SizedBox(height: 16),
          
          // Confirmation du mot de passe
          TextFormField(
            initialValue: widget.formData['passwordConfirmation'] ?? '',
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirmer le mot de passe *',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ est obligatoire';
              }
              if (value != widget.formData['password']) {
                return 'Les mots de passe ne correspondent pas';
              }
              return null;
            },
            onChanged: (value) {
              widget.formData['passwordConfirmation'] = value;
            },
          ),
          const SizedBox(height: 16),
          
          // Date de naissance
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextFormField(
                controller: _selectedDate != null
                    ? TextEditingController(
                        text: '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}')
                    : null,
                decoration: const InputDecoration(
                  labelText: 'Date de naissance',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          // Genre
          DropdownButtonFormField<String>(
            value: _selectedGender,
            decoration: const InputDecoration(
              labelText: 'Genre',
              border: OutlineInputBorder(),
            ),
            items: _genders.map((gender) {
              return DropdownMenuItem(
                value: gender,
                child: Text(gender),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedGender = value;
                widget.formData['gender'] = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
