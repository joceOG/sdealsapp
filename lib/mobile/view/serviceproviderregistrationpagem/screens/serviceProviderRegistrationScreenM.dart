import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/data/services/authCubit.dart';
import 'package:sdealsapp/mobile/view/provider_dashboard/screens/provider_main_screen.dart';
import 'package:sdealsapp/mobile/view/serviceproviderregistrationpagem/screens/steps/provider_personal_info_step.dart';
import 'package:sdealsapp/mobile/view/serviceproviderregistrationpagem/screens/steps/provider_professional_info_step.dart';
import 'package:sdealsapp/mobile/view/serviceproviderregistrationpagem/screens/steps/provider_pricing_step.dart';
import 'package:sdealsapp/mobile/view/serviceproviderregistrationpagem/screens/steps/provider_verification_step.dart';
import 'package:sdealsapp/mobile/view/serviceproviderregistrationpagem/screens/steps/provider_qualifications_step.dart';

import '../serviceproviderregistrationoageblocm/serviceProviderRegistrationPageBlocM.dart';
import '../serviceproviderregistrationoageblocm/serviceProviderRegistrationPageEventM.dart';
import '../serviceproviderregistrationoageblocm/serviceProviderRegistrationPageStateM.dart';

class ServiceProviderRegistrationScreenM extends StatefulWidget {
  const ServiceProviderRegistrationScreenM({Key? key}) : super(key: key);

  @override
  State<ServiceProviderRegistrationScreenM> createState() =>
      _ServiceProviderRegistrationScreenMState();
}

class _ServiceProviderRegistrationScreenMState
    extends State<ServiceProviderRegistrationScreenM> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> formData = {
    'fullName': '',
    'phone': '',
    'email': '',
    'password': '',
    'profileImage': null,
    'birthDate': null,
    'gender': 'Homme',
    'businessName': '',
    'category': 'Plombier',
    'specialties': <String>[],
    'yearsOfExperience': 0,
    'serviceDescription': '',
    'serviceAreas': <String>[],
    'serviceRadius': 0.0,
    'location': null,
    'minimumHourlyRate': 0.0,
    'maximumHourlyRate': 0.0,
    'billingMode': 'Heure',
    'travelFees': false,
    'travelFeesAmount': 0.0,
    'idCardNumber': '',
    'idCardFront': null,
    'idCardBack': null,
    'certificates': <dynamic>[],
    'insurance': {
      'number': '',
      'document': null,
    },
    'businessRegistry': '',
  };

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
      ),
    ];
  }

  void _updateFormData(Map<String, dynamic> newData) {
    setState(() {
      formData.addAll(newData);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // ✅ Injecter l'userId existant s'il est connecté
      final auth = context.read<AuthCubit>().state;
      if (auth is AuthAuthenticated) {
        formData['existingUserId'] = auth.utilisateur.idutilisateur;
      }
      context.read<ServiceProviderRegistrationBlocM>().add(
            SubmitServiceProviderRegistrationEvent(formData: formData),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServiceProviderRegistrationBlocM,
        ServiceProviderRegistrationStateM>(
      listener: (context, state) {
        if (state is ServiceProviderRegistrationLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Envoi en cours...")),
          );
        } else if (state is ServiceProviderRegistrationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => const ProviderMainScreen()),
            );
          });
        } else if (state is ServiceProviderRegistrationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Scaffold(
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
                          _currentStep == _steps.length - 1
                              ? 'Soumettre'
                              : 'Suivant',
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
                          child: const Text(
                            'Précédent',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
