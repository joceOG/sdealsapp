import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WalletPageScreenM extends StatefulWidget {
  const WalletPageScreenM({super.key});

  @override
  State<WalletPageScreenM> createState() => _WalletPageScreenMState();
}

class _WalletPageScreenMState extends State<WalletPageScreenM> {
  // Solde fictif
  double balance = 125000;

  // Pour afficher ou cacher le solde
  bool _showBalance = true;

  // Liste fictive de transactions
  final List<Map<String, dynamic>> transactions = [
    {
      "type": "Rechargé",
      "amount": 50000,
      "date": "31 Mai 2025",
      "icon": Icons.arrow_downward_rounded,
      "color": Colors.green
    },
    {
      "type": "Envoyé",
      "amount": -20000,
      "date": "30 Mai 2025",
      "icon": Icons.arrow_upward_rounded,
      "color": Colors.red
    },
    {
      "type": "Paiement",
      "amount": -15000,
      "date": "29 Mai 2025",
      "icon": Icons.shopping_cart,
      "color": Colors.orange
    },
    {
      "type": "Rechargé",
      "amount": 30000,
      "date": "28 Mai 2025",
      "icon": Icons.arrow_downward_rounded,
      "color": Colors.green
    },
    {
      "type": "Envoyé",
      "amount": -10000,
      "date": "27 Mai 2025",
      "icon": Icons.arrow_upward_rounded,
      "color": Colors.red
    },
  ];

  // Formatteur pour le solde avec séparateurs de milliers et centièmes
  String get formattedBalance {
    final formatter = NumberFormat("#,##0", "fr_FR");
    return formatter.format(balance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // AppBar personnalisée avec photo de profil à droite
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Mon Compte SD',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1.1,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.green.withOpacity(0.13),
              backgroundImage: const AssetImage('assets/profile_picture.jpg'),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  padding: const EdgeInsets.all(2),
                  child:
                      const Icon(Icons.verified, size: 14, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carte virtuelle du solde réorganisée
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 18),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF43EA5E), Color(0xFF1CBF3F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.13),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.account_balance_wallet_rounded,
                              color: Colors.white70, size: 28),
                          const SizedBox(width: 10),
                          const Text(
                            "Solde du compte",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          // Icône œil pour afficher/cacher le solde
                          InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              setState(() {
                                _showBalance = !_showBalance;
                              });
                            },
                            child: Icon(
                              _showBalance
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                          const SizedBox(width: 10),
                          // QR Code fictif
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.13),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(Icons.qr_code_rounded,
                                color: Colors.white, size: 28),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Affichage du solde avec séparateurs ou caché
                      Text(
                        _showBalance ? "$formattedBalance FCFA" : "••••••••",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 18),
                      // Boutons d'action
                      Row(
                        children: [
                          _walletActionButton(
                            icon: Icons.add_circle_outline,
                            label: "Recharger",
                            color: Colors.white,
                            onTap: () {},
                          ),
                          const SizedBox(width: 12),
                          _walletActionButton(
                            icon: Icons.send_rounded,
                            label: "Transférer",
                            color: Colors.white,
                            onTap: () {},
                          ),
                          const SizedBox(width: 12),
                          _walletActionButton(
                            icon: Icons.history,
                            label: "Historique",
                            color: Colors.white,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Titre section transactions
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Dernières transactions",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            ),
            // Liste des transactions
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final tx = transactions[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: (tx['color'] as Color).withOpacity(0.13),
                    child: Icon(tx['icon'], color: tx['color']),
                  ),
                  title: Text(
                    tx['type'],
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(tx['date']),
                  trailing: Text(
                    "${tx['amount'] > 0 ? '+' : ''}${NumberFormat("#,##0.00", "fr_FR").format(tx['amount'])} FCFA",
                    style: TextStyle(
                      color: tx['amount'] > 0 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  /// Widget pour un bouton d'action wallet (recharger, transférer, retirer, etc.)
  Widget _walletActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.13),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 26),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
