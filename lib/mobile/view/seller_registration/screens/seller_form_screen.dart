import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/data/services/authCubit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sdealsapp/mobile/view/seller_registration/screens/steps/seller_personal_info_step.dart';
import 'package:sdealsapp/mobile/view/seller_registration/screens/steps/seller_shop_info_step.dart';
import 'package:sdealsapp/mobile/view/seller_registration/screens/steps/seller_products_step.dart';
import 'package:sdealsapp/mobile/view/seller_registration/screens/steps/seller_payment_step.dart';
import 'package:sdealsapp/mobile/view/seller_registration/screens/steps/seller_verification_step.dart';

class SellerFormScreen extends StatefulWidget {
  final Set<String> preSelectedCategories;
  final Set<String> preSelectedProducts;

  const SellerFormScreen({
    Key? key,
    this.preSelectedCategories = const {},
    this.preSelectedProducts = const {},
  }) : super(key: key);

  @override
  _SellerFormScreenState createState() => _SellerFormScreenState();
}

class _SellerFormScreenState extends State<SellerFormScreen> {
  int _currentStep = 0;
  final Map<String, dynamic> _formData = {};

  @override
  void initState() {
    super.initState();
    _formData['categories'] = widget.preSelectedCategories.toList();
    _formData['products'] = widget.preSelectedProducts.toList();
  }

  void _updateFormData(Map<String, dynamic> data) {
    setState(() {
      _formData.addAll(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription Vendeur'),
        backgroundColor: Colors.amber.shade700,
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepTapped: (step) {
          setState(() {
            _currentStep = step;
          });
        },
        onStepContinue: () async {
          if (_currentStep < _buildFormSteps().length - 1) {
            setState(() {
              _currentStep += 1;
            });
          } else {
            await _submitForm();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
        steps: _buildFormSteps(),
        controlsBuilder: (context, controlDetails) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: controlDetails.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade700,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      _currentStep >= _buildFormSteps().length - 1
                          ? 'Soumettre'
                          : 'Continuer',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                if (_currentStep > 0) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: controlDetails.onStepCancel,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.amber.shade700),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Retour'),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  List<Step> _buildFormSteps() {
    return [
      Step(
        title: const Text('Informations Personnelles'),
        subtitle: const Text('Vos coordonnées et informations de base'),
        content: SellerPersonalInfoStep(
          formData: _formData,
          updateFormData: _updateFormData,
        ),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: const Text('Informations Boutique'),
        subtitle: const Text('Détails sur votre boutique en ligne'),
        content: SellerShopInfoStep(
          formData: _formData,
          updateFormData: _updateFormData,
        ),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: const Text('Produits'),
        subtitle: const Text('Informations sur vos produits'),
        content: SellerProductsStep(
          formData: _formData,
          updateFormData: _updateFormData,
        ),
        isActive: _currentStep >= 2,
      ),
      Step(
        title: const Text('Paiements'),
        subtitle: const Text('Configuration de vos méthodes de paiement'),
        content: SellerPaymentStep(
          formData: _formData,
          updateFormData: _updateFormData,
        ),
        isActive: _currentStep >= 3,
      ),
      Step(
        title: const Text('Vérification'),
        subtitle: const Text('Documents requis pour vérifier votre identité'),
        content: SellerVerificationStep(
          formData: _formData,
          updateFormData: _updateFormData,
        ),
        isActive: _currentStep >= 4,
      ),
    ];
  }

  Future<void> _submitForm() async {
    // Injecter l'userId existant si connecté
    final auth = context.read<AuthCubit>().state;
    if (auth is AuthAuthenticated) {
      _formData['existingUserId'] = auth.utilisateur.idutilisateur;
    }
    final scaffold = ScaffoldMessenger.of(context);
    final apiUrl = dotenv.env['API_URL'];
    if (apiUrl == null || apiUrl.isEmpty) {
      scaffold.showSnackBar(
          const SnackBar(content: Text('API_URL non configurée')));
      return;
    }

    try {
      final uri = Uri.parse('$apiUrl/vendeur');
      final request = http.MultipartRequest('POST', uri);

      final utilisateurId = (_formData['existingUserId'] as String?) ?? '';
      request.fields['utilisateur'] = utilisateurId;
      request.fields['localisation'] = (_formData['location'] as String?) ?? '';
      final List categories = (_formData['shopCategories'] as List?) ??
          (_formData['categories'] as List?) ??
          [];
      request.fields['zonedelivraison'] = categories.join(',');
      request.fields['note'] = (_formData['shopDescription'] as String?) ?? '';
      request.fields['verifier'] = 'false';

      Future<void> attachFileIfExists(String? path, String fieldName) async {
        if (path == null || path.isEmpty) return;
        final file = File(path);
        if (await file.exists()) {
          request.files.add(await http.MultipartFile.fromPath(
              fieldName, file.path,
              filename: p.basename(file.path)));
        }
      }

      await attachFileIfExists(_formData['idFrontPath'] as String?, 'cni1');
      await attachFileIfExists(_formData['idBackPath'] as String?, 'cni2');
      await attachFileIfExists(
          _formData['profileImagePath'] as String?, 'selfie');

      scaffold.showSnackBar(const SnackBar(content: Text('Envoi en cours...')));
      // Ajouter Authorization si token disponible
      final authState = context.read<AuthCubit>().state;
      if (authState is AuthAuthenticated && authState.token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer ${authState.token}';
      }

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!mounted) return;
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Félicitations!'),
            content: const SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 64,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Votre demande d\'inscription vendeur a été soumise avec succès!',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Notre équipe examinera vos informations sous peu. Vous serez notifié lors de la validation.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Revenir à l\'accueil'),
              ),
            ],
          ),
        );
      } else {
        scaffold.showSnackBar(SnackBar(
            content: Text('Erreur: ${response.statusCode} ${response.body}')));
      }
    } catch (e) {
      scaffold.showSnackBar(SnackBar(content: Text('Erreur d\'envoi: $e')));
    }
  }
}
