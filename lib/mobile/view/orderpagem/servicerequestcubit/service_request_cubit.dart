import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../data/services/api_client.dart';

@immutable
abstract class ServiceRequestState {}

class ServiceRequestInitial extends ServiceRequestState {}

class ServiceRequestLoading extends ServiceRequestState {}

class ServiceRequestError extends ServiceRequestState {
  final String message;
  ServiceRequestError(this.message);
}

class ServiceRequestCreated extends ServiceRequestState {
  final Map<String, dynamic> data;
  ServiceRequestCreated(this.data);
}

class ServiceRequestListLoaded extends ServiceRequestState {
  final List<Map<String, dynamic>> items;
  ServiceRequestListLoaded(this.items);
}

class ServiceRequestDetailLoaded extends ServiceRequestState {
  final Map<String, dynamic> data;
  ServiceRequestDetailLoaded(this.data);
}

class ServiceRequestCubit extends Cubit<ServiceRequestState> {
  final ApiClient api;
  ServiceRequestCubit({ApiClient? apiClient})
      : api = apiClient ?? ApiClient(),
        super(ServiceRequestInitial());

  Future<void> submitRequest({
    required String token,
    required String utilisateurId,
    String? prestataireId,
    String? serviceId,
    String? adresse,
    String? ville,
    DateTime? dateHeure,
    String? notesClient,
    String? moyenPaiement,
    num? montant,
  }) async {
    emit(ServiceRequestLoading());
    try {
      final data = await api.createPrestation(
        token: token,
        utilisateurId: utilisateurId,
        prestataireId: prestataireId,
        serviceId: serviceId,
        adresse: adresse,
        ville: ville,
        dateHeure: dateHeure,
        notesClient: notesClient,
        moyenPaiement: moyenPaiement,
        montant: montant,
      );
      emit(ServiceRequestCreated(data));
    } catch (e) {
      emit(ServiceRequestError(e.toString()));
    }
  }

  Future<void> fetchMine({
    required String token,
    required String utilisateurId,
    String? status,
  }) async {
    emit(ServiceRequestLoading());
    try {
      final items = await api.getMyPrestations(
        token: token,
        utilisateurId: utilisateurId,
        status: status,
      );
      emit(ServiceRequestListLoaded(items));
    } catch (e) {
      emit(ServiceRequestError(e.toString()));
    }
  }

  Future<void> getById({required String token, required String id}) async {
    emit(ServiceRequestLoading());
    try {
      final data = await api.getPrestationById(token: token, id: id);
      emit(ServiceRequestDetailLoaded(data));
    } catch (e) {
      emit(ServiceRequestError(e.toString()));
    }
  }

  Future<void> updateStatus({
    required String token,
    required String id,
    required String status,
  }) async {
    emit(ServiceRequestLoading());
    try {
      final data = await api.updatePrestation(
        token: token,
        id: id,
        updates: {'status': status},
      );
      emit(ServiceRequestDetailLoaded(data));
    } catch (e) {
      emit(ServiceRequestError(e.toString()));
    }
  }
}

