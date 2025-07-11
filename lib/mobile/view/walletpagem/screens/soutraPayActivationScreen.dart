import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../soutrapayblocm/soutra_wallet_bloc.dart';
import '../soutrapayblocm/soutra_wallet_event.dart';

class SoutraPayActivationScreen extends StatelessWidget {
  const SoutraPayActivationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFF9500), Color(0xFFFF3B30)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo ou icône SoutraPay
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.account_balance_wallet_rounded,
                      size: 60,
                      color: Colors.orange.shade800,
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Titre principal
                const Text(
                  "Activez votre portefeuille SoutraPay",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                    height: 1.3,
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Liste à puces des avantages
                _buildBulletPoint("Recharges gratuites depuis MTN, Wave, Orange"),
                _buildBulletPoint("Transferts instantanés sécurisés"),
                _buildBulletPoint("Paiements de services sans frais"),
                _buildBulletPoint("Historique détaillé de vos transactions"),
                
                const SizedBox(height: 40),
                
                // Logos partenaires
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPartnerLogo("MTN", Colors.yellow),
                    const SizedBox(width: 20),
                    _buildPartnerLogo("Wave", Colors.blue),
                    const SizedBox(width: 20),
                    _buildPartnerLogo("Orange", Colors.orange),
                  ],
                ),
                
                const Spacer(),
                
                // Bouton d'activation
                ElevatedButton(
                  onPressed: () {
                    // Logique d'activation du wallet via BLoC
                    final soutraWalletBloc = BlocProvider.of<SoutraWalletBloc>(context);
                    soutraWalletBloc.add(ActivateSoutraWallet());
                    
                    // Utilisation de GoRouter pour la navigation
                    GoRouter.of(context).go('/homepage');
                    // Note: Normalement, nous aurions une route dédiée pour le wallet, par exemple:
                    // GoRouter.of(context).go('/wallet');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(double.infinity, 56),
                    elevation: 3,
                  ),
                  child: const Text(
                    "Activer maintenant",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Mention des conditions d'utilisation
                GestureDetector(
                  onTap: () {
                    // Afficher les conditions d'utilisation
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                      children: [
                        TextSpan(text: "En cliquant, vous acceptez les "),
                        TextSpan(
                          text: "Conditions d'utilisation",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            height: 8,
            width: 8,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerLogo(String name, Color color) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
