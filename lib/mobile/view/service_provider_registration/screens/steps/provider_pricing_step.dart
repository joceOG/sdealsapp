import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProviderPricingStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function(Map<String, dynamic>) onDataChanged;

  const ProviderPricingStep({
    Key? key,
    required this.formData,
    required this.onDataChanged,
  }) : super(key: key);

  @override
  State<ProviderPricingStep> createState() => _ProviderPricingStepState();
}

class _ProviderPricingStepState extends State<ProviderPricingStep> {
  final TextEditingController _minimumRateController = TextEditingController();
  final TextEditingController _maximumRateController = TextEditingController();
  final TextEditingController _travelFeesController = TextEditingController();
  String _billingMode = 'Heure';
  bool _hasTravelFees = false;

  final List<String> _billingModes = [
    'Heure', 'Jour', 'Forfait', 'Devis'
  ];

  @override
  void initState() {
    super.initState();
    _initializeFormValues();
  }

  void _initializeFormValues() {
    _minimumRateController.text = widget.formData['minimumHourlyRate']?.toString() ?? '';
    _maximumRateController.text = widget.formData['maximumHourlyRate']?.toString() ?? '';
    _billingMode = widget.formData['billingMode'] ?? 'Heure';
    _hasTravelFees = widget.formData['travelFees'] ?? false;
    _travelFeesController.text = widget.formData['travelFeesAmount']?.toString() ?? '';
  }

  @override
  void dispose() {
    _minimumRateController.dispose();
    _maximumRateController.dispose();
    _travelFeesController.dispose();
    super.dispose();
  }

  void _updateFormData() {
    Map<String, dynamic> updatedData = {
      'minimumHourlyRate': double.tryParse(_minimumRateController.text) ?? 0.0,
      'maximumHourlyRate': double.tryParse(_maximumRateController.text) ?? 0.0,
      'billingMode': _billingMode,
      'travelFees': _hasTravelFees,
      'travelFeesAmount': _hasTravelFees ? double.tryParse(_travelFeesController.text) ?? 0.0 : 0.0,
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
            'Tarification',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Tarif horaire minimum
          TextFormField(
            controller: _minimumRateController,
            decoration: const InputDecoration(
              labelText: 'Tarif horaire minimum (FCFA) *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.money),
              suffixText: 'FCFA',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un tarif minimum';
              }
              return null;
            },
            onChanged: (value) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Tarif horaire maximum
          TextFormField(
            controller: _maximumRateController,
            decoration: const InputDecoration(
              labelText: 'Tarif horaire maximum (FCFA) *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.money),
              suffixText: 'FCFA',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer un tarif maximum';
              }
              final minRate = double.tryParse(_minimumRateController.text) ?? 0;
              final maxRate = double.tryParse(value) ?? 0;
              if (maxRate < minRate) {
                return 'Le tarif maximum doit être supérieur au tarif minimum';
              }
              return null;
            },
            onChanged: (value) => _updateFormData(),
          ),
          const SizedBox(height: 16),

          // Mode de facturation
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Mode de facturation',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.receipt),
            ),
            value: _billingMode,
            items: _billingModes.map((mode) {
              return DropdownMenuItem<String>(
                value: mode,
                child: Text(mode),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _billingMode = value!;
              });
              _updateFormData();
            },
          ),
          const SizedBox(height: 20),

          // Frais de déplacement
          SwitchListTile(
            title: const Text('Frais de déplacement'),
            subtitle: const Text('Appliquez-vous des frais de déplacement ?'),
            value: _hasTravelFees,
            activeColor: Colors.orange,
            onChanged: (bool value) {
              setState(() {
                _hasTravelFees = value;
              });
              _updateFormData();
            },
          ),
          
          if (_hasTravelFees) ...[
            const SizedBox(height: 16),
            TextFormField(
              controller: _travelFeesController,
              decoration: const InputDecoration(
                labelText: 'Montant des frais de déplacement (FCFA)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.directions_car),
                suffixText: 'FCFA',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) => _updateFormData(),
            ),
          ],
          
          const SizedBox(height: 24),
          
          // Explication de la tarification
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue.shade800),
                    const SizedBox(width: 8),
                    const Text(
                      'Comment fonctionne la tarification ?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  '• Les tarifs horaires minimum et maximum permettent aux clients de connaître votre fourchette de prix.',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                const Text(
                  '• Le mode de facturation définit comment vous comptabilisez vos services.',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                const Text(
                  '• Les frais de déplacement sont optionnels et s\'ajoutent au prix du service.',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                const Text(
                  '• Vous pourrez toujours négocier le prix final directement avec vos clients.',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
