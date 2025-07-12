import 'package:flutter/material.dart';

class SellerProductsStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function(Map<String, dynamic>) updateFormData;

  const SellerProductsStep({
    Key? key,
    required this.formData,
    required this.updateFormData,
  }) : super(key: key);

  @override
  _SellerProductsStepState createState() => _SellerProductsStepState();
}

class _SellerProductsStepState extends State<SellerProductsStep> {
  final _formKey = GlobalKey<FormState>();
  
  String? _selectedPreparationTime;
  final List<String> _preparationTimes = ['1 jour', '2-3 jours', '3-5 jours', '1 semaine'];
  
  final Map<String, bool> _deliveryMethods = {
    'Livraison à domicile': true,
    'Points relais': false,
    'Retrait en boutique': false,
  };

  String? _selectedReturnPolicy;
  final List<String> _returnPolicies = ['Accepté (14 jours)', 'Accepté (7 jours)', 'Cas par cas', 'Non accepté'];

  final TextEditingController _customerServiceHoursController = TextEditingController();
  
  final Map<String, String> _deliveryZones = {};
  final TextEditingController _zoneNameController = TextEditingController();
  final TextEditingController _zoneFeeController = TextEditingController();
  
  // Adresse physique
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _communeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    // Pré-remplir avec les données existantes si disponibles
    if (widget.formData.containsKey('preparationTime')) {
      _selectedPreparationTime = widget.formData['preparationTime'];
    }
    
    if (widget.formData.containsKey('deliveryMethods') && widget.formData['deliveryMethods'] is Map) {
      final Map<String, dynamic> methods = widget.formData['deliveryMethods'];
      methods.forEach((key, value) {
        if (_deliveryMethods.containsKey(key)) {
          _deliveryMethods[key] = value;
        }
      });
    }
    
    if (widget.formData.containsKey('returnPolicy')) {
      _selectedReturnPolicy = widget.formData['returnPolicy'];
    }
    
    if (widget.formData.containsKey('customerServiceHours')) {
      _customerServiceHoursController.text = widget.formData['customerServiceHours'];
    } else {
      _customerServiceHoursController.text = '08:00 - 18:00, Lundi au Samedi';
    }
    
    if (widget.formData.containsKey('deliveryZones') && widget.formData['deliveryZones'] is Map) {
      final Map<String, dynamic> zones = widget.formData['deliveryZones'];
      zones.forEach((key, value) {
        _deliveryZones[key] = value.toString();
      });
    }
    
    if (widget.formData.containsKey('physicalAddress')) {
      _addressController.text = widget.formData['physicalAddress'];
    }
    
    if (widget.formData.containsKey('commune')) {
      _communeController.text = widget.formData['commune'];
    }
    
    if (widget.formData.containsKey('city')) {
      _cityController.text = widget.formData['city'];
    }
    
    if (widget.formData.containsKey('landmark')) {
      _landmarkController.text = widget.formData['landmark'];
    }
  }

  @override
  void dispose() {
    _customerServiceHoursController.dispose();
    _zoneNameController.dispose();
    _zoneFeeController.dispose();
    _addressController.dispose();
    _communeController.dispose();
    _cityController.dispose();
    _landmarkController.dispose();
    super.dispose();
  }

  void _addDeliveryZone() {
    final zoneName = _zoneNameController.text.trim();
    final zoneFee = _zoneFeeController.text.trim();
    
    if (zoneName.isNotEmpty && zoneFee.isNotEmpty) {
      setState(() {
        _deliveryZones[zoneName] = zoneFee;
        _zoneNameController.clear();
        _zoneFeeController.clear();
      });
      
      widget.updateFormData({
        'deliveryZones': _deliveryZones,
      });
    }
  }

  void _removeDeliveryZone(String zoneName) {
    setState(() {
      _deliveryZones.remove(zoneName);
    });
    
    widget.updateFormData({
      'deliveryZones': _deliveryZones,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        // Sauvegarde automatique à chaque changement
        if (_formKey.currentState!.validate()) {
          widget.updateFormData({
            'physicalAddress': _addressController.text,
            'commune': _communeController.text,
            'city': _cityController.text,
            'landmark': _landmarkController.text,
            'preparationTime': _selectedPreparationTime,
            'deliveryMethods': _deliveryMethods,
            'returnPolicy': _selectedReturnPolicy,
            'customerServiceHours': _customerServiceHoursController.text,
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Adresse Physique',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _addressController,
            decoration: const InputDecoration(
              labelText: 'Adresse complète *',
              prefixIcon: Icon(Icons.location_on),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Veuillez entrer une adresse physique';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _communeController,
                  decoration: const InputDecoration(
                    labelText: 'Commune',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'Ville *',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ville requise';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _landmarkController,
            decoration: const InputDecoration(
              labelText: 'Point de repère (optionnel)',
              prefixIcon: Icon(Icons.assistant_direction),
              border: OutlineInputBorder(),
              hintText: 'Ex: À côté de la station Total',
            ),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          const Text(
            'Zones de livraison',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Ajoutez les zones où vous pouvez livrer et les frais associés',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: _zoneNameController,
                  decoration: const InputDecoration(
                    labelText: 'Zone/Quartier',
                    border: OutlineInputBorder(),
                    hintText: 'Ex: Cocody',
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: _zoneFeeController,
                  decoration: const InputDecoration(
                    labelText: 'Frais (FCFA)',
                    border: OutlineInputBorder(),
                    hintText: '1000',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              IconButton(
                onPressed: _addDeliveryZone,
                icon: const Icon(Icons.add_circle),
                color: Colors.amber.shade700,
                iconSize: 32,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _deliveryZones.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Aucune zone de livraison ajoutée',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _deliveryZones.length,
                  itemBuilder: (context, index) {
                    final zoneName = _deliveryZones.keys.elementAt(index);
                    final zoneFee = _deliveryZones[zoneName];
                    
                    return ListTile(
                      title: Text(zoneName),
                      subtitle: Text('$zoneFee FCFA'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: () => _removeDeliveryZone(zoneName),
                      ),
                    );
                  },
                ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          const Text(
            'Logistique',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Délai de préparation *',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            children: _preparationTimes.map((time) {
              final isSelected = _selectedPreparationTime == time;
              return ChoiceChip(
                label: Text(time),
                selected: isSelected,
                onSelected: (_) {
                  setState(() {
                    _selectedPreparationTime = time;
                  });
                  widget.updateFormData({
                    'preparationTime': time,
                  });
                },
                backgroundColor: Colors.grey.shade100,
                selectedColor: Colors.amber.shade100,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.amber.shade800 : Colors.black,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Modes de livraison *',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: _deliveryMethods.entries.map((entry) {
              return CheckboxListTile(
                title: Text(entry.key),
                value: entry.value,
                activeColor: Colors.amber.shade700,
                onChanged: (bool? value) {
                  if (value != null) {
                    setState(() {
                      _deliveryMethods[entry.key] = value;
                    });
                    widget.updateFormData({
                      'deliveryMethods': _deliveryMethods,
                    });
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Politique de retour *',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _returnPolicies.map((policy) {
              final isSelected = _selectedReturnPolicy == policy;
              return ChoiceChip(
                label: Text(policy),
                selected: isSelected,
                onSelected: (_) {
                  setState(() {
                    _selectedReturnPolicy = policy;
                  });
                  widget.updateFormData({
                    'returnPolicy': policy,
                  });
                },
                backgroundColor: Colors.grey.shade100,
                selectedColor: Colors.amber.shade100,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.amber.shade800 : Colors.black,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Horaires service client *',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _customerServiceHoursController,
            decoration: const InputDecoration(
              hintText: 'Ex: 8h-18h du Lundi au Samedi',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Veuillez indiquer vos horaires de service client';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 8.0),
            child: Text(
              'Période pendant laquelle vous êtes joignable',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
