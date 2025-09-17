import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PricingStep extends StatefulWidget {
  final Map<String, dynamic> formData;

  const PricingStep({Key? key, required this.formData}) : super(key: key);

  @override
  _PricingStepState createState() => _PricingStepState();
}

class _PricingStepState extends State<PricingStep> {
  final TextEditingController _hourlyRateController = TextEditingController();
  final TextEditingController _dailyRateController = TextEditingController();
  final TextEditingController _minProjectRateController = TextEditingController();
  String? _selectedCurrency;

  // Devises disponibles
  final List<String> _currencies = ['FCFA', 'EUR', 'USD', 'GBP', 'MAD'];

  @override
  void initState() {
    super.initState();
    // Initialiser avec les données existantes si disponibles
    _hourlyRateController.text = widget.formData['hourlyRate']?.toString() ?? '';
    _dailyRateController.text = widget.formData['dailyRate']?.toString() ?? '';
    _minProjectRateController.text = widget.formData['minProjectRate']?.toString() ?? '';
    _selectedCurrency = widget.formData['currency'] ?? 'FCFA';
  }

  @override
  void dispose() {
    _hourlyRateController.dispose();
    _dailyRateController.dispose();
    _minProjectRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '💰 Tarification',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          
          // Devise préférée
          DropdownButtonFormField<String>(
            value: _selectedCurrency,
            decoration: const InputDecoration(
              labelText: 'Devise *',
              border: OutlineInputBorder(),
            ),
            items: _currencies.map((currency) {
              return DropdownMenuItem(
                value: currency,
                child: Text(currency),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCurrency = value;
                widget.formData['currency'] = value;
              });
            },
          ),
          const SizedBox(height: 16),
          
          // Tarif horaire
          TextFormField(
            controller: _hourlyRateController,
            decoration: InputDecoration(
              labelText: 'Tarif horaire *',
              hintText: '0',
              border: const OutlineInputBorder(),
              prefixIcon: Container(
                width: 60,
                alignment: Alignment.center,
                child: Text(
                  _selectedCurrency ?? 'FCFA',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ est obligatoire';
              }
              if (int.tryParse(value) == null || int.parse(value) <= 0) {
                return 'Veuillez entrer un montant valide';
              }
              return null;
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                widget.formData['hourlyRate'] = int.tryParse(value);
              }
            },
          ),
          const SizedBox(height: 16),
          
          // Tarif journalier
          TextFormField(
            controller: _dailyRateController,
            decoration: InputDecoration(
              labelText: 'Tarif journalier (optionnel)',
              hintText: '0',
              border: const OutlineInputBorder(),
              prefixIcon: Container(
                width: 60,
                alignment: Alignment.center,
                child: Text(
                  _selectedCurrency ?? 'FCFA',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              if (value.isNotEmpty) {
                widget.formData['dailyRate'] = int.tryParse(value);
              } else {
                widget.formData['dailyRate'] = null;
              }
            },
          ),
          const SizedBox(height: 16),
          
          // Tarif de projet minimum
          TextFormField(
            controller: _minProjectRateController,
            decoration: InputDecoration(
              labelText: 'Tarif de projet minimum *',
              hintText: '0',
              border: const OutlineInputBorder(),
              prefixIcon: Container(
                width: 60,
                alignment: Alignment.center,
                child: Text(
                  _selectedCurrency ?? 'FCFA',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
              helperText: 'Montant minimum pour un projet complet',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ce champ est obligatoire';
              }
              if (int.tryParse(value) == null || int.parse(value) <= 0) {
                return 'Veuillez entrer un montant valide';
              }
              return null;
            },
            onChanged: (value) {
              if (value.isNotEmpty) {
                widget.formData['minProjectRate'] = int.tryParse(value);
              }
            },
          ),
          const SizedBox(height: 24),
          
          // Guide de tarification
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
                      'Guide de tarification',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Conseils pour définir vos tarifs:',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                const Text('• Considérez votre niveau d\'expérience'),
                const Text('• Recherchez les tarifs moyens du marché'),
                const Text('• Prenez en compte la complexité de vos services'),
                const Text('• N\'oubliez pas les frais de commission de la plateforme (15%)'),
                const SizedBox(height: 8),
                const Text(
                  'Exemples par catégorie (FCFA/heure):',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                const Text('• Développement: 5 000 - 15 000'),
                const Text('• Design: 3 000 - 10 000'),
                const Text('• Rédaction: 2 000 - 7 000'),
                const Text('• Marketing: 3 500 - 12 000'),
              ],
            ),
          ),
          
          // Note sur la négociation
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.grey.shade600),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Note: Les clients pourront vous proposer des tarifs personnalisés lors des discussions.',
                    style: TextStyle(fontStyle: FontStyle.italic),
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
