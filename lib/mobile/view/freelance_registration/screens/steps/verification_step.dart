import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class VerificationStep extends StatefulWidget {
  final Map<String, dynamic> formData;

  const VerificationStep({Key? key, required this.formData}) : super(key: key);

  @override
  _VerificationStepState createState() => _VerificationStepState();
}

class _VerificationStepState extends State<VerificationStep> {
  final ImagePicker _picker = ImagePicker();
  XFile? _idFrontImage;
  XFile? _idBackImage;

  @override
  void initState() {
    super.initState();
    // Initialiser avec les données existantes si disponibles
    if (widget.formData['idFrontPath'] != null) {
      _idFrontImage = XFile(widget.formData['idFrontPath']);
    }
    
    if (widget.formData['idBackPath'] != null) {
      _idBackImage = XFile(widget.formData['idBackPath']);
    }
  }

  Future<void> _pickImage(bool isFront) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    
    if (pickedFile != null) {
      setState(() {
        if (isFront) {
          _idFrontImage = pickedFile;
          widget.formData['idFrontPath'] = pickedFile.path;
        } else {
          _idBackImage = pickedFile;
          widget.formData['idBackPath'] = pickedFile.path;
        }
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
            '📋 Vérification',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Explication
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.verified_user, color: Colors.blue.shade700),
                    const SizedBox(width: 8),
                    const Text(
                      'Pourquoi la vérification d\'identité ?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'La vérification d\'identité est nécessaire pour :',
                ),
                const SizedBox(height: 4),
                const Text('• Assurer la sécurité des utilisateurs de la plateforme'),
                const Text('• Confirmer votre identité réelle'),
                const Text('• Faciliter les paiements sécurisés'),
                const Text('• Prévenir les fraudes et comportements malveillants'),
                const SizedBox(height: 8),
                const Text(
                  'Vos documents sont stockés de manière sécurisée et ne sont utilisés que pour la vérification de votre identité.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Photo CNI recto
          const Text(
            'Photo CNI recto *',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _pickImage(true),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _idFrontImage == null ? Colors.grey.shade400 : Colors.green.shade700,
                  width: _idFrontImage == null ? 1 : 2,
                ),
                image: _idFrontImage != null
                    ? DecorationImage(
                        image: FileImage(File(_idFrontImage!.path)),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: _idFrontImage == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_a_photo,
                          size: 40,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Cliquez pour ajouter la photo recto',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    )
                  : null,
            ),
          ),
          if (_idFrontImage == null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Cette photo est obligatoire',
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontSize: 12,
                ),
              ),
            ),
          const SizedBox(height: 20),
          
          // Photo CNI verso
          const Text(
            'Photo CNI verso *',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _pickImage(false),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _idBackImage == null ? Colors.grey.shade400 : Colors.green.shade700,
                  width: _idBackImage == null ? 1 : 2,
                ),
                image: _idBackImage != null
                    ? DecorationImage(
                        image: FileImage(File(_idBackImage!.path)),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: _idBackImage == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_a_photo,
                          size: 40,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Cliquez pour ajouter la photo verso',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    )
                  : null,
            ),
          ),
          if (_idBackImage == null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Cette photo est obligatoire',
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontSize: 12,
                ),
              ),
            ),
          const SizedBox(height: 24),
          
          // Instructions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: Colors.amber.shade800),
                    const SizedBox(width: 8),
                    const Text(
                      'Conseils pour les photos',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('• Assurez-vous que le document est bien visible'),
                const Text('• Évitez les reflets ou ombres sur le document'),
                const Text('• Prenez la photo dans un endroit bien éclairé'),
                const Text('• Toutes les informations doivent être lisibles'),
                const Text('• La photo doit être nette et de bonne qualité'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
