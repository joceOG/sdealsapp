import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../orderpagem/servicerequestcubit/service_request_cubit.dart';

class ServiceRequestSummaryScreen extends StatelessWidget {
  final String requestId;
  final String token;
  const ServiceRequestSummaryScreen(
      {super.key, required this.requestId, required this.token});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ServiceRequestCubit()..getById(token: token, id: requestId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Résumé de commande'),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<ServiceRequestCubit, ServiceRequestState>(
          builder: (context, state) {
            if (state is ServiceRequestLoading ||
                state is ServiceRequestInitial) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.green));
            } else if (state is ServiceRequestError) {
              return Center(child: Text(state.message));
            } else if (state is ServiceRequestDetailLoaded) {
              final data = state.data;
              final status = data['status']?.toString() ?? 'PENDING';
              final adresse = data['adresse']?.toString() ?? '';
              final ville = data['ville']?.toString() ?? '';
              final notes = data['notesClient']?.toString() ?? '';
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.miscellaneous_services,
                            color: Colors.green),
                        const SizedBox(width: 8),
                        Text('Statut: $status',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (adresse.isNotEmpty) Text('Adresse: $adresse'),
                    if (ville.isNotEmpty) Text('Ville: $ville'),
                    if (notes.isNotEmpty) Text('Notes: $notes'),
                    const SizedBox(height: 20),
                    const Text('Timeline',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _buildTimeline(status),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildTimeline(String status) {
    final steps = ['PENDING', 'ACCEPTED', 'IN_PROGRESS', 'DONE'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: steps.map((s) {
        final reached = steps.indexOf(s) <= steps.indexOf(status);
        return Column(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: reached ? Colors.green : Colors.grey.shade300,
              child: Icon(Icons.check,
                  size: 14,
                  color: reached ? Colors.white : Colors.grey.shade500),
            ),
            const SizedBox(height: 6),
            Text(s,
                style: TextStyle(
                    fontSize: 10, color: reached ? Colors.black : Colors.grey)),
          ],
        );
      }).toList(),
    );
  }
}

