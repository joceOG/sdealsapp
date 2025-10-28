import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/prestataire_registration.dart';

// 🎯 ÉTAPE VÉRIFICATION ET DOCUMENTS
class VerificationStep extends StatefulWidget {
  const VerificationStep({super.key});

  @override
  State<VerificationStep> createState() => _VerificationStepState();
}

class _VerificationStepState extends State<VerificationStep> {
  final _formKey = GlobalKey<FormState>();
  String _photoProfil = '';
  String _pieceIdentite = '';
  List<String> _documents = [];

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
              'Vérification et documents',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Téléchargez vos documents pour finaliser votre inscription',
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
                    // Photo de profil
                    _buildSection(
                      title: 'Photo de profil *',
                      subtitle: 'Une photo claire de votre visage',
                      child: _buildPhotoUpload(
                        value: _photoProfil,
                        onChanged: (value) {
                          setState(() {
                            _photoProfil = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'La photo de profil est requise';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Pièce d'identité
                    _buildSection(
                      title: 'Pièce d\'identité *',
                      subtitle: 'CNI, Passeport ou Permis de conduire',
                      child: _buildDocumentUpload(
                        value: _pieceIdentite,
                        onChanged: (value) {
                          setState(() {
                            _pieceIdentite = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'La pièce d\'identité est requise';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Documents supplémentaires
                    _buildSection(
                      title: 'Documents supplémentaires',
                      subtitle:
                          'Certificats, diplômes, attestations (optionnel)',
                      child: _buildAdditionalDocuments(),
                    ),
                    const SizedBox(height: 32),

                    // Récapitulatif
                    _buildSection(
                      title: 'Récapitulatif',
                      subtitle: 'Vérifiez vos informations avant validation',
                      child: _buildSummary(),
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
                  'Finaliser l\'inscription',
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

  // 🎯 UPLOAD DE PHOTO
  Widget _buildPhotoUpload({
    required String value,
    required ValueChanged<String> onChanged,
    String? Function(String?)? validator,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          if (value.isEmpty)
            GestureDetector(
              onTap: () => _uploadPhoto(),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.grey.shade400,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Ajouter une photo',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(value),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => onChanged(''),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          Text(
            'Formats acceptés: JPG, PNG, WEBP\nTaille max: 5MB',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // 🎯 UPLOAD DE DOCUMENT
  Widget _buildDocumentUpload({
    required String value,
    required ValueChanged<String> onChanged,
    String? Function(String?)? validator,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          if (value.isEmpty)
            GestureDetector(
              onTap: () => _uploadDocument(),
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    style: BorderStyle.solid,
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.upload_file,
                      color: Colors.grey.shade400,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Télécharger un document',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF4CAF50)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.description,
                    color: Color(0xFF4CAF50),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Document téléchargé',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4CAF50),
                          ),
                        ),
                        Text(
                          'Cliquez pour changer',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => onChanged(''),
                    child: const Icon(
                      Icons.close,
                      color: Color(0xFF4CAF50),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          Text(
            'Formats acceptés: PDF, JPG, PNG\nTaille max: 10MB',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // 🎯 DOCUMENTS SUPPLÉMENTAIRES
  Widget _buildAdditionalDocuments() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          // Liste des documents
          if (_documents.isNotEmpty)
            ..._documents.map((doc) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF4CAF50)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.description,
                        color: Color(0xFF4CAF50),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          doc,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF4CAF50),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _documents.remove(doc);
                          });
                        },
                        child: const Icon(
                          Icons.close,
                          color: Color(0xFF4CAF50),
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                )),

          // Bouton d'ajout
          GestureDetector(
            onTap: () => _uploadAdditionalDocument(),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade300,
                  style: BorderStyle.solid,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.grey.shade400,
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ajouter un document',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🎯 RÉCAPITULATIF
  Widget _buildSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          _buildSummaryItem(
              'Photo de profil', _photoProfil.isNotEmpty ? '✓' : '✗'),
          _buildSummaryItem(
              'Pièce d\'identité', _pieceIdentite.isNotEmpty ? '✓' : '✗'),
          _buildSummaryItem(
              'Documents supplémentaires', '${_documents.length} document(s)'),
        ],
      ),
    );
  }

  // 🎯 ÉLÉMENT DU RÉCAPITULATIF
  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF374151),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: value.startsWith('✓')
                  ? Colors.green
                  : value.startsWith('✗')
                      ? Colors.red
                      : const Color(0xFF4CAF50),
            ),
          ),
        ],
      ),
    );
  }

  // 🎯 UPLOAD DE PHOTO
  void _uploadPhoto() {
    // Simuler l'upload
    setState(() {
      _photoProfil =
          'https://via.placeholder.com/150x150/4CAF50/FFFFFF?text=Photo';
    });
  }

  // 🎯 UPLOAD DE DOCUMENT
  void _uploadDocument() {
    // Simuler l'upload
    setState(() {
      _pieceIdentite = 'piece_identite.pdf';
    });
  }

  // 🎯 UPLOAD DE DOCUMENT SUPPLÉMENTAIRE
  void _uploadAdditionalDocument() {
    // Simuler l'upload
    setState(() {
      _documents.add('document_${_documents.length + 1}.pdf');
    });
  }

  // 🎯 VALIDATION ET SAUVEGARDE
  void _validateAndSave() {
    if (_formKey.currentState!.validate()) {
      if (_photoProfil.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez télécharger une photo de profil'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_pieceIdentite.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez télécharger une pièce d\'identité'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      context.read<PrestataireRegistrationBloc>().add(
            SaveDocuments(
              documents: _documents,
              photoProfil: _photoProfil,
              pieceIdentite: _pieceIdentite,
            ),
          );
    }
  }
}
