import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'soutraRechargeScreen.dart';
import 'soutraTransferScreen.dart';

class SoutraWalletMainScreen extends StatefulWidget {
  const SoutraWalletMainScreen({Key? key}) : super(key: key);

  @override
  State<SoutraWalletMainScreen> createState() => _SoutraWalletMainScreenState();
}

class _SoutraWalletMainScreenState extends State<SoutraWalletMainScreen> {
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
      "color": Colors.green,
      "method": "MTN Money"
    },
    {
      "type": "Envoyé",
      "amount": -20000,
      "date": "30 Mai 2025",
      "icon": Icons.arrow_upward_rounded,
      "color": Colors.red,
      "method": "SoutraPay"
    },
    {
      "type": "Paiement",
      "amount": -15000,
      "date": "29 Mai 2025",
      "icon": Icons.shopping_cart,
      "color": Colors.orange,
      "method": "Achat en ligne"
    },
    {
      "type": "Rechargé",
      "amount": 30000,
      "date": "28 Mai 2025",
      "icon": Icons.arrow_downward_rounded,
      "color": Colors.green,
      "method": "Wave"
    },
    {
      "type": "Envoyé",
      "amount": -10000,
      "date": "27 Mai 2025",
      "icon": Icons.arrow_upward_rounded,
      "color": Colors.red,
      "method": "Orange Money"
    },
  ];

  // Formatteur pour le solde avec séparateurs de milliers
  String get formattedBalance {
    final formatter = NumberFormat("#,##0", "fr_FR");
    return formatter.format(balance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // AppBar personnalisée avec photo de profil et QR code
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Mon Compte SoutraPay',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          // Bouton pour afficher le QR code
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.qr_code, color: Colors.black87),
            ),
            onPressed: () {
              // Logique pour afficher le QR code
              _showQRCodeSheet(context);
            },
          ),
          // Photo de profil
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                // Navigation vers le profil SoutraPay
                Navigator.pushNamed(context, '/wallet/profile');
              },
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
                    child: const Icon(Icons.verified, size: 14, color: Colors.white),
                  ),
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
            // Carte solde avec animation
            _buildBalanceCard(),
            
            const SizedBox(height: 24),
            
            // Titre section transactions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Dernières transactions",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Navigation vers l'historique complet
                  },
                  child: const Text(
                    "Voir tout",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
            // Liste des transactions avec animation
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final tx = transactions[index];
                return _buildTransactionItem(tx);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Carte de solde améliorée
  Widget _buildBalanceCard() {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 5),
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
            color: Colors.green.withOpacity(0.2),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.account_balance_wallet_rounded,
                    color: Colors.white70, size: 28),
                const SizedBox(width: 10),
                const Text(
                  "Solde disponible",
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
              ],
            ),
            const SizedBox(height: 16),
            // Affichage du solde avec animation
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _showBalance 
                ? Text(
                    "$formattedBalance FCFA",
                    key: const ValueKey("balance"),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  )
                : const Text(
                    "••••••••",
                    key: ValueKey("hidden"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
            ),
            const SizedBox(height: 24),
            // Boutons d'action
            Row(
              children: [
                _walletActionButton(
                  icon: Icons.add_circle_outline,
                  label: "Recharger",
                  color: Colors.white,
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const SoutraRechargeScreen()),
                    );
                  },
                ),
                const SizedBox(width: 12),
                _walletActionButton(
                  icon: Icons.send_rounded,
                  label: "Transférer",
                  color: Colors.white,
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const SoutraTransferScreen()),
                    );
                  },
                ),
                const SizedBox(width: 12),
                _walletActionButton(
                  icon: Icons.history,
                  label: "Historique",
                  color: Colors.white,
                  onTap: () {
                    // Navigation vers l'historique
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Item de transaction amélioré
  Widget _buildTransactionItem(Map<String, dynamic> tx) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      leading: CircleAvatar(
        backgroundColor: (tx['color'] as Color).withOpacity(0.13),
        radius: 25,
        child: Icon(tx['icon'], color: tx['color'], size: 24),
      ),
      title: Text(
        tx['type'],
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(tx['date'], style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 2),
          Text(
            tx['method'],
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
      trailing: Text(
        "${tx['amount'] > 0 ? '+' : ''}${NumberFormat("#,##0", "fr_FR").format(tx['amount'])} FCFA",
        style: TextStyle(
          color: tx['amount'] > 0 ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  // Bouton d'action wallet (recharger, transférer, etc.)
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

  // Bottom sheet pour afficher le QR Code
  void _showQRCodeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => Container(
        height: 350,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 5,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Votre QR Code SoutraPay",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(
                  Icons.qr_code_2,
                  size: 150,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Partagez ce QR code pour recevoir de l'argent",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
