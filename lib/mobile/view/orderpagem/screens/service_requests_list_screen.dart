import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/data/services/authCubit.dart';
import '../servicerequestcubit/service_request_cubit.dart';
import 'service_request_summary_screen.dart';

class ServiceRequestsListScreen extends StatelessWidget {
  const ServiceRequestsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthCubit>().state;
    if (auth is! AuthAuthenticated) {
      return const Scaffold(
        body: Center(child: Text('Veuillez vous connecter.')),
      );
    }
    return BlocProvider(
      create: (_) => ServiceRequestCubit()
        ..fetchMine(
            token: auth.token, utilisateurId: auth.utilisateur.idutilisateur),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mes demandes de services'),
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
            } else if (state is ServiceRequestListLoaded) {
              final items = state.items;
              if (items.isEmpty) {
                return const Center(
                    child: Text('Aucune demande pour le moment.'));
              }
              return ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final it = items[index];
                  final status = it['status']?.toString() ?? 'PENDING';
                  final adresse = it['adresse']?.toString() ?? '';
                  final ville = it['ville']?.toString() ?? '';
                  return ListTile(
                    leading: Icon(Icons.work_outline,
                        color: status == 'DONE' ? Colors.green : Colors.grey),
                    title: Text('Statut: $status'),
                    subtitle: Text([adresse, ville]
                        .where((e) => e.isNotEmpty)
                        .join(' · ')),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      final id = it['_id']?.toString();
                      if (id != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ServiceRequestSummaryScreen(
                                requestId: id, token: auth.token),
                          ),
                        );
                      }
                    },
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
