import 'package:flutter/material.dart';

class AIInsightsWidget extends StatelessWidget {
  final List<String> insights;
  
  const AIInsightsWidget({
    Key? key,
    required this.insights,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.2), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Insights IA - Analyse de Marché',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...insights.map((insight) => _buildInsightItem(context, insight)).toList(),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () {
                  // Navigation vers une analyse plus détaillée
                },
                child: const Text('Voir analyse complète →'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightItem(BuildContext context, String insight) {
    IconData icon;
    Color color;
    
    // Déterminer l'icône et la couleur en fonction du contenu de l'insight
    if (insight.toLowerCase().contains('forte') || 
        insight.toLowerCase().contains('hausse') || 
        insight.toLowerCase().contains('augment')) {
      icon = Icons.trending_up;
      color = Colors.green;
    } else if (insight.toLowerCase().contains('baisse') || 
               insight.toLowerCase().contains('diminution')) {
      icon = Icons.trending_down;
      color = Colors.red;
    } else if (insight.toLowerCase().contains('prix') || 
               insight.toLowerCase().contains('tarif')) {
      icon = Icons.attach_money;
      color = Colors.amber;
    } else if (insight.toLowerCase().contains('client') || 
               insight.toLowerCase().contains('satisfaction')) {
      icon = Icons.people;
      color = Colors.blue;
    } else {
      icon = Icons.lightbulb;
      color = Colors.purple;
    }
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              insight,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
