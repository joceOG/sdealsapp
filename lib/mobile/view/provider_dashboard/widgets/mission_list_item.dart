import 'package:flutter/material.dart';

class MissionListItem extends StatelessWidget {
  final String title;
  final String location;
  final String price;
  final String urgency;
  final String distance;
  final VoidCallback onTap;

  const MissionListItem({
    Key? key,
    required this.title,
    required this.location,
    required this.price,
    required this.urgency,
    required this.distance,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Titre avec icône adaptée au type de mission
                  Row(
                    children: [
                      // Icône basée sur le type de mission (déterminé par le titre)
                      Icon(
                        _getIconForMission(title),
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  
                  // Badge d'urgence
                  if (urgency.toLowerCase() == 'urgent')
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.priority_high, color: Colors.red, size: 14),
                          SizedBox(width: 2),
                          Text(
                            'URGENT',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Localisation et distance
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    location,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.directions_walk, size: 16, color: Colors.grey[400]),
                  const SizedBox(width: 4),
                  Text(
                    distance,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Prix
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.account_balance_wallet_outlined, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        price,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  // Bouton "Voir"
                  TextButton(
                    onPressed: onTap,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('Voir détails'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Méthode pour déterminer l'icône en fonction du type de mission
  IconData _getIconForMission(String missionTitle) {
    final title = missionTitle.toLowerCase();
    
    if (title.contains('plomberie') || title.contains('robinet') || title.contains('fuite') || title.contains('canalisation')) {
      return Icons.plumbing;
    } else if (title.contains('électricité') || title.contains('électrique') || title.contains('lampe')) {
      return Icons.electrical_services;
    } else if (title.contains('climatisation') || title.contains('clim')) {
      return Icons.ac_unit;
    } else if (title.contains('ménage') || title.contains('nettoyage')) {
      return Icons.cleaning_services;
    } else if (title.contains('transport') || title.contains('déménagement')) {
      return Icons.local_shipping;
    } else if (title.contains('jardin') || title.contains('plante')) {
      return Icons.yard;
    } else if (title.contains('peinture') || title.contains('décoration')) {
      return Icons.format_paint;
    } else {
      return Icons.handyman;
    }
  }
}
