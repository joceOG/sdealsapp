import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SoutraRechargeScreen extends StatefulWidget {
  const SoutraRechargeScreen({Key? key}) : super(key: key);

  @override
  State<SoutraRechargeScreen> createState() => _SoutraRechargeScreenState();
}

class _SoutraRechargeScreenState extends State<SoutraRechargeScreen> {
  // Numéro de téléphone sélectionné
  String selectedNumber = "+225 07 12 34 56";
  
  // Liste des numéros associés
  final List<String> phoneNumbers = [
    "+225 07 12 34 56",
    "+225 01 98 76 54",
  ];
  
  // Montant à recharger
  double amount = 0;
  final TextEditingController amountController = TextEditingController();
  
  // Formatteur pour le montant
  String get formattedAmount {
    if (amount == 0) return "0";
    final formatter = NumberFormat("#,##0", "fr_FR");
    return formatter.format(amount);
  }
  
  @override
  void initState() {
    super.initState();
    amountController.addListener(() {
      setState(() {
        amount = double.tryParse(amountController.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      });
    });
  }
  
  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Recharger mon compte',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sélection du numéro
            const Text(
              "Sélectionner un numéro",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedNumber,
                  isExpanded: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  borderRadius: BorderRadius.circular(12),
                  items: phoneNumbers.map((String number) {
                    return DropdownMenuItem<String>(
                      value: number,
                      child: Text(number),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedNumber = newValue;
                      });
                    }
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Montant à recharger
            const Text(
              "Montant à recharger",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Saisir le montant",
                  suffixText: "FCFA",
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Boutons de montant rapide
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _quickAmountButton("1 000"),
                _quickAmountButton("3 000"),
                _quickAmountButton("5 000"),
                _quickAmountButton("10 000"),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Bandeau promotionnel
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange.shade200, Colors.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow[100], size: 40),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      "Vérifiez votre identité pour débloquer des recharges plus importantes!",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Bouton de recharge
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: amount > 0 ? _showPaymentMethodBottomSheet : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  disabledBackgroundColor: Colors.grey[300],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Recharger $formattedAmount FCFA",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Bouton de montant rapide
  Widget _quickAmountButton(String amount) {
    return InkWell(
      onTap: () {
        setState(() {
          amountController.text = amount.replaceAll(" ", "");
          this.amount = double.tryParse(amount.replaceAll(" ", "").replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Text(
          "$amount FCFA",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Affiche la bottom sheet pour sélectionner le moyen de paiement
  void _showPaymentMethodBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => SelectPaymentMethodSheet(
        amount: amount,
        onPaymentSelected: (method) {
          // Naviguer vers l'écran de confirmation de rechargement
          Navigator.pop(context);
          _navigateToConfirmation(method);
        },
      ),
    );
  }

  // Navigation vers l'écran de confirmation
  void _navigateToConfirmation(String paymentMethod) {
    // Cette fonction serait implémentée pour naviguer vers l'écran de confirmation
    // Navigator.push(context, MaterialPageRoute(builder: (context) => SoutraRechargeConfirmationScreen()));
  }
}

// Widget pour la sélection du moyen de paiement
class SelectPaymentMethodSheet extends StatelessWidget {
  final double amount;
  final Function(String) onPaymentSelected;

  const SelectPaymentMethodSheet({
    Key? key,
    required this.amount,
    required this.onPaymentSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Choisir un moyen de paiement",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            "Pour recharger ${NumberFormat("#,##0", "fr_FR").format(amount)} FCFA",
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          _buildPaymentMethodTile(
            context: context,
            name: "MTN Mobile Money",
            icon: Icons.phone_android,
            color: Colors.yellow[700]!,
            onTap: () => onPaymentSelected("MTN Mobile Money"),
          ),
          _buildPaymentMethodTile(
            context: context,
            name: "Orange Money",
            icon: Icons.account_balance_wallet,
            color: Colors.orange,
            onTap: () => onPaymentSelected("Orange Money"),
          ),
          _buildPaymentMethodTile(
            context: context,
            name: "Wave",
            icon: Icons.water_drop,
            color: Colors.blue,
            onTap: () => onPaymentSelected("Wave"),
          ),
          const SizedBox(height: 16),
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              // Logique pour ajouter un nouveau numéro
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add_circle_outline,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Ajouter un nouveau moyen de paiement",
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.w600,
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

  Widget _buildPaymentMethodTile({
    required BuildContext context,
    required String name,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.2),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 16),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
