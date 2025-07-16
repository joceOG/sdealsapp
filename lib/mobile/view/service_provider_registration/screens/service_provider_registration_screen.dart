import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/mobile/view/jobpagem/jobpageblocm/jobPageBlocM.dart';
import 'package:sdealsapp/mobile/view/jobpagem/jobpageblocm/jobPageEventM.dart';
import 'package:sdealsapp/mobile/view/jobpagem/jobpageblocm/jobPageStateM.dart';
import 'package:sdealsapp/mobile/view/provider_dashboard/screens/provider_main_screen.dart';
import 'package:sdealsapp/mobile/view/service_provider_registration/screens/steps/provider_personal_info_step.dart';
import 'package:sdealsapp/mobile/view/service_provider_registration/screens/steps/provider_professional_info_step.dart';
import 'package:sdealsapp/mobile/view/service_provider_registration/screens/steps/provider_pricing_step.dart';
import 'package:sdealsapp/mobile/view/service_provider_registration/screens/steps/provider_verification_step.dart';
import 'package:sdealsapp/mobile/view/service_provider_registration/screens/steps/provider_qualifications_step.dart';

class ServiceProviderRegistrationScreen extends StatelessWidget {
  const ServiceProviderRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => JobPageBlocM()
        ..add(LoadCategorieDataM()),
      child: const _ServiceProviderRegistrationContent(),
    );
  }
}

class _ServiceProviderRegistrationContent extends StatefulWidget {
  const _ServiceProviderRegistrationContent({Key? key}) : super(key: key);

  @override
  State<_ServiceProviderRegistrationContent> createState() => _ServiceProviderRegistrationContentState();
}

class _ServiceProviderRegistrationContentState extends State<_ServiceProviderRegistrationContent> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  
  // Données du formulaire
  final Map<String, dynamic> formData = {
    // Informations personnelles
    'fullName': '',
    'phone': '',
    'email': '',
    'password': '',
    'profileImage': null,
    'birthDate': null,
    'gender': 'Homme', // Valeur par défaut pour éviter l'erreur dans le dropdown
    
    // Informations professionnelles
    'businessName': '',
    'category': 'Plombier', // Valeur par défaut pour éviter l'erreur dans le dropdown
    'specialties': <String>[],
    'yearsOfExperience': 0,
    'serviceDescription': '',
    'serviceAreas': <String>[],
    'serviceRadius': 0.0,
    'location': null, // Pour stocker la latitude et longitude
    
    // Tarification
    'minimumHourlyRate': 0.0,
    'maximumHourlyRate': 0.0,
    'billingMode': 'Heure',
    'travelFees': false,
    'travelFeesAmount': 0.0,
    
    // Vérification KYC
    'idCardNumber': '',
    'idCardFront': null,
    'idCardBack': null,
    
    // Qualifications
    'certificates': <dynamic>[],
    'insurance': {
      'number': '',
      'document': null,
    },
    'businessRegistry': '',
  };
  
  // Liste des étapes
  late List<Step> _steps;
  
  @override
  void initState() {
    super.initState();
    _initializeSteps();
  }
  
  void _initializeSteps() {
    _steps = [
      Step(
        title: const Text('Informations personnelles'),
        content: ProviderPersonalInfoStep(
          formData: formData,
          onDataChanged: _updateFormData,
        ),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: const Text('Informations professionnelles'),
        content: ProviderProfessionalInfoStep(
          formData: formData,
          onDataChanged: _updateFormData,
        ),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: const Text('Tarification'),
        content: ProviderPricingStep(
          formData: formData,
          onDataChanged: _updateFormData,
        ),
        isActive: _currentStep >= 2,
      ),
      Step(
        title: const Text('Vérification'),
        content: ProviderVerificationStep(
          formData: formData,
          onDataChanged: _updateFormData,
        ),
        isActive: _currentStep >= 3,
      ),
      Step(
        title: const Text('Qualifications'),
        content: ProviderQualificationsStep(
          formData: formData,
          onDataChanged: _updateFormData,
        ),
        isActive: _currentStep >= 4,
        state: StepState.indexed,
      ),
    ];
  }
  
  void _updateFormData(Map<String, dynamic> newData) {
    setState(() {
      formData.addAll(newData);
    });
  }
  
  void _submitForm() {
    // TODO: Implémenter l'envoi du formulaire à l'API
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Félicitations ! Votre inscription en tant que prestataire a été validée.'))
    );
    
    // Redirection vers l'interface prestataire après soumission réussie
    Future.delayed(const Duration(seconds: 2), () {
      // Utiliser pushReplacement qui est plus compatible avec différents systèmes de navigation
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ProviderMainScreen(),
        ),
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobPageBlocM, JobPageStateM>(
      builder: (context, state) {
        if (state.isLoading ?? true) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        
        return Scaffold(
          appBar: AppBar(
            title: const Text('Devenir prestataire'),
            backgroundColor: Colors.orange,
          ),
          body: Form(
            key: _formKey,
            child: Stepper(
              type: StepperType.vertical,
              currentStep: _currentStep,
              steps: _steps,
              onStepContinue: () {
                setState(() {
                  if (_currentStep < _steps.length - 1) {
                    _currentStep++;
                  } else {
                    // Dernière étape, soumettre le formulaire
                    _submitForm();
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (_currentStep > 0) {
                    _currentStep--;
                  }
                });
              },
              controlsBuilder: (context, details) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            _currentStep == _steps.length - 1 ? 'Soumettre' : 'Suivant',
                            style: const TextStyle(fontSize: 16),
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
                            child: const Text('Précédent', style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
