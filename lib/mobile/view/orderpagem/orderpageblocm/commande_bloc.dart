import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/commande_model.dart';
import 'commande_event.dart';
import 'commande_state.dart';

class CommandeBloc extends Bloc<CommandeEvent, CommandeState> {
  CommandeBloc() : super(CommandeState.initial()) {
    on<ChargerCommandes>(_onChargerCommandes);
    on<FiltrerParStatus>(_onFiltrerParStatus);
    on<AjouterCommande>(_onAjouterCommande);
    on<MettreAJourCommande>(_onMettreAJourCommande);
    on<NoterCommande>(_onNoterCommande);
    on<RechercherCommandes>(_onRechercherCommandes);
    on<AnnulerCommande>(_onAnnulerCommande);
  }

  Future<void> _onChargerCommandes(
    ChargerCommandes event,
    Emitter<CommandeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      // Ici, on utiliserait normalement une API pour récupérer les commandes
      // Pour l'exemple, on utilise les données simulées
      await Future.delayed(const Duration(seconds: 1)); // Simulation de délai réseau
      
      emit(state.copyWith(
        isLoading: false,
        commandes: commandesSimulees,
      ));
    } catch (error) {
      emit(state.copyWith(
        isLoading: false,
        error: error.toString(),
      ));
    }
  }

  void _onFiltrerParStatus(
    FiltrerParStatus event,
    Emitter<CommandeState> emit,
  ) {
    emit(state.copyWith(filtreStatus: event.status));
  }

  void _onAjouterCommande(
    AjouterCommande event,
    Emitter<CommandeState> emit,
  ) {
    final updatedCommandes = [...state.commandes, event.commande];
    emit(state.copyWith(commandes: updatedCommandes));
  }

  void _onMettreAJourCommande(
    MettreAJourCommande event,
    Emitter<CommandeState> emit,
  ) {
    final updatedCommandes = state.commandes.map((commande) {
      if (commande.id == event.commande.id) {
        return event.commande;
      }
      return commande;
    }).toList();
    
    emit(state.copyWith(commandes: updatedCommandes));
  }

  void _onNoterCommande(
    NoterCommande event,
    Emitter<CommandeState> emit,
  ) {
    final updatedCommandes = state.commandes.map((commande) {
      if (commande.id == event.commandeId) {
        return commande.copyWith(
          estNotee: true,
          note: event.note,
          commentaire: event.commentaire,
        );
      }
      return commande;
    }).toList();
    
    emit(state.copyWith(commandes: updatedCommandes));
  }

  void _onRechercherCommandes(
    RechercherCommandes event,
    Emitter<CommandeState> emit,
  ) {
    emit(state.copyWith(searchQuery: event.query));
  }

  void _onAnnulerCommande(
    AnnulerCommande event,
    Emitter<CommandeState> emit,
  ) {
    final updatedCommandes = state.commandes.map((commande) {
      if (commande.id == event.commandeId) {
        return commande.copyWith(status: CommandeStatus.annulee);
      }
      return commande;
    }).toList();
    
    emit(state.copyWith(commandes: updatedCommandes));
  }
}
