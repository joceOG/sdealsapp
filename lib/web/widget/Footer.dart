import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.grey.shade900,
          ],
        ),
      ),
      child: Column(
        children: [
          // Section principale du footer
          Container(
            margin: const EdgeInsets.only(top: 80.0),
            padding:
                const EdgeInsets.symmetric(vertical: 60.0, horizontal: 40.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section "Pour mieux nous connaître"
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pour mieux nous connaître',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Jost',
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildFooterLink('Gagner de l\'argent', () {}),
                      _buildFooterLink('Moyens de paiement Soutrali', () {}),
                      _buildFooterLink('Besoin d\'aide ?', () {}),
                      const SizedBox(height: 20),
                      const Text(
                        'Rejoignez notre communauté de prestataires et clients satisfaits.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: 'Jost',
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 60),

                // Section Newsletter
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Newsletter',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Jost',
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Restez informé de nos dernières actualités et offres spéciales.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: 'Jost',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'E-mail',
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontFamily: 'Jost',
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'Jost',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 4,
                                ),
                                onPressed: () {
                                  // Action à effectuer lors du clic
                                },
                                child: const Text(
                                  'Subscribe',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Jost',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),

                      // Réseaux sociaux
                      const Text(
                        'Suivez-nous',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'Jost',
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          _buildSocialButton(
                            icon: FontAwesomeIcons.facebook,
                            color: Colors.blue.shade600,
                            onTap: () {},
                          ),
                          const SizedBox(width: 15),
                          _buildSocialButton(
                            icon: FontAwesomeIcons.instagram,
                            color: Colors.pink.shade400,
                            onTap: () {},
                          ),
                          const SizedBox(width: 15),
                          _buildSocialButton(
                            icon: FontAwesomeIcons.twitter,
                            color: Colors.blue.shade400,
                            onTap: () {},
                          ),
                          const SizedBox(width: 15),
                          _buildSocialButton(
                            icon: FontAwesomeIcons.linkedin,
                            color: Colors.blue.shade700,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Séparateur
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 40.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.grey.shade600,
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Section logo et copyright
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo original SOUTRALI DEALS
                    Image.asset(
                      'assets/logo1.png',
                      width: 300,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  '© Soutrali Deals 2024 - Tous droits réservés',
                  style: TextStyle(
                    fontFamily: 'Jost',
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Plateforme de services professionnels en Côte d\'Ivoire',
                  style: TextStyle(
                    fontFamily: 'Jost',
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Jost',
            fontSize: 16,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
