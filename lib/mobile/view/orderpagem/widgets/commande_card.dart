import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/models/commande_model.dart';

class CommandeCard extends StatelessWidget {
  final CommandeModel commande;
  final VoidCallback onViewDetails;
  final VoidCallback onChat;
  final VoidCallback? onRate;

  const CommandeCard({
    Key? key,
    required this.commande,
    required this.onViewDetails,
    required this.onChat,
    this.onRate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.currency(
      symbol: 'FCFA ',
      decimalDigits: 0,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Material(
        color: Colors.white,
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onViewDetails,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // En-tête avec photo prestataire, nom et statut
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.green.withOpacity(0.05)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Photo prestataire
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(commande.prestataireImage),
                        backgroundColor: Colors.grey.shade200,
                      ),
                      const SizedBox(width: 12),
                      // Informations principales
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              commande.prestataireName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(
                                  Icons.category,
                                  size: 14,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    commande.typeService,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    commande.dateFormatee,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Badge statut
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: commande.statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: commande.statusColor.withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getIconForStatus(commande.status),
                                size: 12,
                                color: commande.statusColor,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                commande.statusText,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: commande.statusColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Séparateur
                const Divider(height: 1),
                // Section prix et actions
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Prix
                      Row(
                        children: [
                          Icon(
                            Icons.payments_outlined,
                            size: 18,
                            color: Colors.green.shade700,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            formatCurrency.format(commande.montant),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Actions
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _buildActionButton(
                              onTap: onChat,
                              icon: Icons.chat_bubble_outline,
                              label: "Chat",
                            ),
                            const SizedBox(width: 8),
                            _buildActionButton(
                              onTap: onViewDetails,
                              icon: Icons.visibility,
                              label: "Détails",
                              primary: true,
                            ),
                            const SizedBox(width: 8),
                            if (commande.peutEtreNotee && onRate != null)
                              _buildActionButton(
                                onTap: onRate!,
                                icon: Icons.star_border,
                                label: "Noter",
                                color: Colors.amber,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Détermine l'icône à utiliser pour le statut
  IconData _getIconForStatus(CommandeStatus status) {
    switch (status) {
      case CommandeStatus.enAttente:
        return Icons.hourglass_empty;
      case CommandeStatus.enCours:
        return Icons.directions_run;
      case CommandeStatus.terminee:
        return Icons.check_circle_outline;
      case CommandeStatus.annulee:
        return Icons.cancel_outlined;
    }
  }

  // Construit un bouton d'action
  Widget _buildActionButton({
    required VoidCallback onTap,
    required IconData icon,
    required String label,
    bool primary = false,
    Color? color,
  }) {
    final buttonColor = color ?? (primary ? Colors.green : Colors.grey.shade700);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: primary ? buttonColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: buttonColor.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: buttonColor,
            ),
            const SizedBox(width: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: buttonColor,
                fontWeight: primary ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
