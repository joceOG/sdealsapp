import 'package:flutter/material.dart';

class SellerPaymentStep extends StatefulWidget {
  final Map<String, dynamic> formData;
  final Function(Map<String, dynamic>) updateFormData;

  const SellerPaymentStep({
    Key? key,
    required this.formData,
    required this.updateFormData,
  }) : super(key: key);

  @override
  _SellerPaymentStepState createState() => _SellerPaymentStepState();
}

class _SellerPaymentStepState extends State<SellerPaymentStep> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedPaymentMethod;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderNameController = TextEditingController();

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 'orange_money',
      'name': 'Orange Money',
      'icon': Icons.account_balance_wallet,
      'color': Colors.orange,
      'type': 'mobile_money'
    },
    {
      'id': 'mtn_money',
      'name': 'MTN Money',
      'icon': Icons.account_balance_wallet,
      'color': Colors.yellow.shade700,
      'type': 'mobile_money'
    },
    {
      'id': 'moov_money',
      'name': 'Moov Money',
      'icon': Icons.account_balance_wallet,
      'color': Colors.blue,
      'type': 'mobile_money'
    },
    {
      'id': 'wave_money',
      'name': 'Wave Money',
      'icon': Icons.account_balance_wallet,
      'color': Colors.teal,
      'type': 'mobile_money'
    },
    {
      'id': 'visa',
      'name': 'Visa',
      'icon': Icons.credit_card,
      'color': Colors.blue.shade800,
      'type': 'card'
    },
    {
      'id': 'mastercard',
      'name': 'Mastercard',
      'icon': Icons.credit_card,
      'color': Colors.red,
      'type': 'card'
    },
    {
      'id': 'other',
      'name': 'Autre',
      'icon': Icons.payments,
      'color': Colors.grey,
      'type': 'other'
    }
  ];

  bool get _isMobileMoneySelected => _getSelectedPaymentType() == 'mobile_money';
  bool get _isCardSelected => _getSelectedPaymentType() == 'card';
  bool get _isOtherSelected => _getSelectedPaymentType() == 'other';

  @override
  void initState() {
    super.initState();
    
    // Pré-remplir avec les données existantes si disponibles
    if (widget.formData.containsKey('paymentMethod')) {
      _selectedPaymentMethod = widget.formData['paymentMethod'];
    }
    
    if (widget.formData.containsKey('paymentPhoneNumber')) {
      _phoneNumberController.text = widget.formData['paymentPhoneNumber'];
    }
    
    if (widget.formData.containsKey('paymentAccountName')) {
      _accountNameController.text = widget.formData['paymentAccountName'];
    }
    
    if (widget.formData.containsKey('cardNumber')) {
      _cardNumberController.text = widget.formData['cardNumber'];
    }
    
    if (widget.formData.containsKey('cardHolderName')) {
      _cardHolderNameController.text = widget.formData['cardHolderName'];
    }
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _accountNameController.dispose();
    _cardNumberController.dispose();
    _cardHolderNameController.dispose();
    super.dispose();
  }

  String? _getSelectedPaymentType() {
    if (_selectedPaymentMethod != null) {
      for (final method in _paymentMethods) {
        if (method['id'] == _selectedPaymentMethod) {
          return method['type'] as String?;
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        // Sauvegarde automatique à chaque changement
        if (_formKey.currentState!.validate()) {
          _saveFormData();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard(),
          const SizedBox(height: 24),
          const Text(
            'Méthode de paiement préférée *',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildPaymentMethodsGrid(),
          const SizedBox(height: 24),
          if (_isMobileMoneySelected) _buildMobileMoneyFields(),
          if (_isCardSelected) _buildCardFields(),
          if (_isOtherSelected) _buildOtherPaymentFields(),
          const SizedBox(height: 20),
          const Text(
            'Note: Vous pourrez ajouter d\'autres méthodes de paiement plus tard dans votre tableau de bord vendeur.',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet,
                color: Colors.amber.shade700,
              ),
              const SizedBox(width: 8),
              const Text(
                'Informations de paiement',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Ces informations sont utilisées pour vous verser l\'argent de vos ventes. Les paiements sont effectués 48h après la confirmation de la livraison.',
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _paymentMethods.length,
      itemBuilder: (context, index) {
        final method = _paymentMethods[index];
        final isSelected = _selectedPaymentMethod == method['id'];
        
        return InkWell(
          onTap: () {
            setState(() {
              _selectedPaymentMethod = method['id'] as String;
            });
            
            widget.updateFormData({
              'paymentMethod': method['id'],
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? (method['color'] as Color).withOpacity(0.1) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? method['color'] as Color : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  method['icon'] as IconData,
                  color: method['color'] as Color,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  method['name'] as String,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? method['color'] as Color : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileMoneyFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informations ${_getSelectedPaymentMethodName()}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _phoneNumberController,
          decoration: const InputDecoration(
            labelText: 'Numéro de téléphone *',
            prefixIcon: Icon(Icons.phone),
            border: OutlineInputBorder(),
            hintText: 'Ex: 07 07 07 07 07',
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (_isMobileMoneySelected && (value == null || value.isEmpty)) {
              return 'Veuillez entrer votre numéro de téléphone';
            }
            if (_isMobileMoneySelected && !RegExp(r'^\d{10}$').hasMatch(value!.replaceAll(RegExp(r'\D'), ''))) {
              return 'Numéro de téléphone invalide';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _accountNameController,
          decoration: const InputDecoration(
            labelText: 'Nom sur le compte *',
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(),
            hintText: 'Nom complet enregistré sur le compte',
          ),
          validator: (value) {
            if (_isMobileMoneySelected && (value == null || value.trim().isEmpty)) {
              return 'Veuillez entrer le nom sur le compte';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCardFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informations ${_getSelectedPaymentMethodName()}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _cardNumberController,
          decoration: const InputDecoration(
            labelText: 'Numéro de carte *',
            prefixIcon: Icon(Icons.credit_card),
            border: OutlineInputBorder(),
            hintText: 'XXXX XXXX XXXX XXXX',
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (_isCardSelected && (value == null || value.isEmpty)) {
              return 'Veuillez entrer votre numéro de carte';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _cardHolderNameController,
          decoration: const InputDecoration(
            labelText: 'Nom du titulaire *',
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(),
            hintText: 'Nom complet sur la carte',
          ),
          validator: (value) {
            if (_isCardSelected && (value == null || value.trim().isEmpty)) {
              return 'Veuillez entrer le nom du titulaire';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildOtherPaymentFields() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Autre méthode de paiement',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Notre équipe vous contactera pour configurer votre méthode de paiement personnalisée une fois votre compte vérifié.',
        ),
      ],
    );
  }

  String _getSelectedPaymentMethodName() {
    if (_selectedPaymentMethod != null) {
      for (final method in _paymentMethods) {
        if (method['id'] == _selectedPaymentMethod) {
          return method['name'] as String;
        }
      }
    }
    return 'de paiement';
  }

  void _saveFormData() {
    final Map<String, dynamic> data = {
      'paymentMethod': _selectedPaymentMethod,
    };
    
    if (_isMobileMoneySelected) {
      data['paymentPhoneNumber'] = _phoneNumberController.text;
      data['paymentAccountName'] = _accountNameController.text;
    } else if (_isCardSelected) {
      data['cardNumber'] = _cardNumberController.text;
      data['cardHolderName'] = _cardHolderNameController.text;
    }
    
    widget.updateFormData(data);
  }
}
