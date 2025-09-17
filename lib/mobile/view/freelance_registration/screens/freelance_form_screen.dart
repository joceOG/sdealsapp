import 'package:flutter/material.dart';
import 'package:sdealsapp/mobile/view/freelance_registration/screens/steps/personal_info_step.dart';
import 'package:sdealsapp/mobile/view/freelance_registration/screens/steps/professional_info_step.dart';
import 'package:sdealsapp/mobile/view/freelance_registration/screens/steps/availability_step.dart';
import 'package:sdealsapp/mobile/view/freelance_registration/screens/steps/pricing_step.dart';
import 'package:sdealsapp/mobile/view/freelance_registration/screens/steps/verification_step.dart';
import 'package:sdealsapp/mobile/view/freelance_registration/screens/steps/portfolio_step.dart';

class FreelanceFormScreen extends StatefulWidget {
  final Set<String>? preSelectedCategories;
  final Set<String>? preSelectedServices;

  const FreelanceFormScreen({
    Key? key,
    this.preSelectedCategories,
    this.preSelectedServices,
  }) : super(key: key);

  @override
  _FreelanceFormScreenState createState() => _FreelanceFormScreenState();
}

class _FreelanceFormScreenState extends State<FreelanceFormScreen> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Données du formulaire
  final Map<String, dynamic> formData = {};

  // Liste des étapes
  late List<Step> _formSteps;

  @override
  void initState() {
    super.initState();
    // Initialiser les données pré-sélectionnées
    if (widget.preSelectedCategories != null) {
      formData['selectedCategories'] = widget.preSelectedCategories;
    } else {
      formData['selectedCategories'] = <String>{};
    }

    if (widget.preSelectedServices != null) {
      formData['selectedServices'] = widget.preSelectedServices;
    } else {
      formData['selectedServices'] = <String>{};
    }

    _buildFormSteps();
  }

  void _buildFormSteps() {
    _formSteps = [
      Step(
        title: const Text('Informations personnelles'),
        content: PersonalInfoStep(
          formData: formData,
        ),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: const Text('Profil professionnel'),
        content: ProfessionalInfoStep(
          formData: formData,
        ),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: const Text('Disponibilité'),
        content: AvailabilityStep(
          formData: formData,
        ),
        isActive: _currentStep >= 2,
      ),
      Step(
        title: const Text('Tarification'),
        content: PricingStep(
          formData: formData,
        ),
        isActive: _currentStep >= 3,
      ),
      Step(
        title: const Text('Vérification'),
        content: VerificationStep(
          formData: formData,
        ),
        isActive: _currentStep >= 4,
      ),
      Step(
        title: const Text('Portfolio & Références'),
        content: PortfolioStep(
          formData: formData,
        ),
        isActive: _currentStep >= 5,
      ),
    ];
  }

  void _nextStep() {
    if (_currentStep < _formSteps.length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      // Soumettre le formulaire
      _submitForm();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      // Afficher un dialogue de confirmation
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirmation'),
          content: const Text(
              'Votre demande d\'inscription freelance a été soumise avec succès. Nous examinerons votre profil et vous contacterons prochainement.'),
          actions: [
            TextButton(
              onPressed: () {
                // Retourner à la page d'accueil
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription Freelance'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          onStepContinue: _nextStep,
          onStepCancel: _previousStep,
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        _currentStep < _formSteps.length - 1 ? 'SUIVANT' : 'SOUMETTRE',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  if (_currentStep > 0) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: details.onStepCancel,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text('RETOUR'),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
          steps: _formSteps,
        ),
      ),
    );
  }
}
