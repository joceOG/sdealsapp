import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SoutraRechargeConfirmationScreen extends StatelessWidget {
  final String paymentMethod;
  final String phoneNumber;
  final double amount;
  
  const SoutraRechargeConfirmationScreen({
    Key? key,
    required this.paymentMethod,
    required this.phoneNumber,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Formateur pour le montant avec séparateurs de milliers
    final formatter = NumberFormat("#,##0", "fr_FR");
    final formattedAmount = formatter.format(amount);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Confirmer le rechargement',
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
      body: Column(
        children: [
          // Partie supérieure avec résumé
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icône de transaction
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.account_balance_wallet,
                        color: Colors.green,
                        size: 50,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Montant
                  Center(
                    child: Text(
                      "$formattedAmount FCFA",
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  // Description
                  Center(
                    child: Text(
                      "Rechargement de compte SoutraPay",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Détails de la transaction
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Détails de la transaction",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildDetailRow("Méthode de paiement", paymentMethod),
                        const Divider(height: 24),
                        _buildDetailRow("Numéro de téléphone", phoneNumber),
                        const Divider(height: 24),
                        _buildDetailRow("Frais de service", "Gratuit"),
                        const Divider(height: 24),
                        _buildDetailRow("Total à payer", "$formattedAmount FCFA", isBold: true),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Note importante
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.orange.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Vous allez recevoir une notification sur $paymentMethod pour confirmer cette transaction.",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Bouton de confirmation
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () => _processRecharge(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Confirmer",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Ligne de détail avec label et valeur
  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 15,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            fontSize: isBold ? 16 : 15,
          ),
        ),
      ],
    );
  }
  
  // Traiter le rechargement
  void _processRecharge(BuildContext context) {
    // Simuler le chargement
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(),
            ),
            SizedBox(height: 20),
            Text("Traitement en cours..."),
          ],
        ),
      ),
    );
    
    // Simuler un délai de traitement
    Future.delayed(const Duration(seconds: 2), () {
      // Fermer la boîte de dialogue de chargement
      Navigator.pop(context);
      
      // Afficher le succès
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 70,
              ),
              const SizedBox(height: 20),
              const Text(
                "Rechargement réussi !",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Votre compte a été crédité de ${NumberFormat("#,##0", "fr_FR").format(amount)} FCFA",
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Fermer toutes les boîtes de dialogue et revenir à l'écran principal
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("Terminer"),
            ),
          ],
        ),
      );
    });
  }
}
