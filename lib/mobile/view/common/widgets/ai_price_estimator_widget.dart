import 'package:flutter/material.dart';
import 'package:sdealsapp/ai_services/interfaces/price_estimation_service.dart';
import 'package:sdealsapp/ai_services/mock_implementations/mock_price_estimation_service.dart';
import 'package:sdealsapp/ai_services/models/ai_recommendation_model.dart';

class AIPriceEstimatorWidget extends StatefulWidget {
  final String serviceCategory;
  final String location;
  final String jobDescription;
  
  const AIPriceEstimatorWidget({
    Key? key,
    required this.serviceCategory,
    required this.location,
    required this.jobDescription,
  }) : super(key: key);

  @override
  _AIPriceEstimatorWidgetState createState() => _AIPriceEstimatorWidgetState();
}

class _AIPriceEstimatorWidgetState extends State<AIPriceEstimatorWidget> {
  final PriceEstimationService _priceService = MockPriceEstimationService();
  AIPriceEstimation? _priceEstimation;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _getPriceEstimation();
  }

  Future<void> _getPriceEstimation() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });
      
      final estimation = await _priceService.estimatePrice(
        serviceType: widget.serviceCategory,
        location: widget.location,
        additionalFactors: {'jobDescription': widget.jobDescription},
      );
      
      setState(() {
        _priceEstimation = estimation;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Impossible d\'obtenir l\'estimation de prix: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

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
                  Icons.payments_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Estimation IA de Prix',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (_error != null)
              Center(
                child: Column(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red),
                    const SizedBox(height: 8),
                    Text(
                      _error!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _getPriceEstimation,
                      child: const Text('Réessayer'),
                    ),
                  ],
                ),
              )
            else
              _buildEstimationDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildEstimationDetails() {
    if (_priceEstimation == null) {
      return const Text('Aucune estimation disponible');
    }

    final formatPrice = (double price) {
      return '${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ')} FCFA';
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              const TextSpan(
                text: 'Service: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: widget.serviceCategory),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              const TextSpan(
                text: 'Localisation: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: widget.location),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Fourchette de prix',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _priceEstimation!.formattedPriceRange,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Prix moyen'),
                  Text(
                    formatPrice((_priceEstimation!.minPrice + _priceEstimation!.maxPrice) / 2),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Facteurs influençant le prix:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        ...(_priceEstimation!.factors.map(
          (factor) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, size: 16, color: Colors.green),
                const SizedBox(width: 6),
                Expanded(child: Text(factor)),
              ],
            ),
          ),
        )),
        const SizedBox(height: 12),
        Center(
          child: Text(
            'Estimation basée sur l\'analyse de données de marché',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
