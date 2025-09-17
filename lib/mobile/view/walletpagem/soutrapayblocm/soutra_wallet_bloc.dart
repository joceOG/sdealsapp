import 'package:flutter_bloc/flutter_bloc.dart';
import 'soutra_wallet_event.dart';
import 'soutra_wallet_state.dart';
import 'models/soutra_wallet_model.dart';

class SoutraWalletBloc extends Bloc<SoutraWalletEvent, SoutraWalletState> {
  // Données mockées pour le portefeuille
  final double _initialBalance = 0;
  final List<SoutraTransaction> _initialTransactions = [];

  SoutraWalletBloc() : super(SoutraWalletState.initial()) {
    on<LoadSoutraWallet>(_onLoadSoutraWallet);
    on<ActivateSoutraWallet>(_onActivateSoutraWallet);
    on<RechargeSoutraWallet>(_onRechargeSoutraWallet);
    on<TransferSoutraWallet>(_onTransferSoutraWallet);
    on<ToggleSoutraBalanceVisibility>(_onToggleSoutraBalanceVisibility);
    on<AddSoutraTransaction>(_onAddSoutraTransaction);
  }

  void _onLoadSoutraWallet(
    LoadSoutraWallet event,
    Emitter<SoutraWalletState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    
    try {
      // Simuler un chargement depuis une API
      await Future.delayed(const Duration(milliseconds: 800));
      
      // Dans une implémentation réelle, vous feriez un appel à votre backend
      // Ici, nous utilisons des données mockées
      final wallet = SoutraWalletModel(
        balance: _initialBalance,
        isActivated: false,
        transactions: _initialTransactions,
      );
      
      emit(state.copyWith(
        wallet: wallet,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  void _onActivateSoutraWallet(
    ActivateSoutraWallet event,
    Emitter<SoutraWalletState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    
    try {
      // Simuler un appel API pour activer le portefeuille
      await Future.delayed(const Duration(seconds: 1));
      
      // Mettre à jour l'état avec le portefeuille activé
      final updatedWallet = state.wallet.copyWith(isActivated: true);
      
      emit(state.copyWith(
        wallet: updatedWallet,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  void _onRechargeSoutraWallet(
    RechargeSoutraWallet event,
    Emitter<SoutraWalletState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    
    try {
      // Simuler un appel API pour recharger le portefeuille
      await Future.delayed(const Duration(seconds: 1));
      
      // Créer une nouvelle transaction
      final transaction = SoutraTransaction(
        type: 'Rechargement',
        amount: event.amount,
        date: DateTime.now(),
        comment: 'Via ${event.method}',
      );
      
      // Mettre à jour le solde et ajouter la transaction
      final updatedWallet = state.wallet.copyWith(
        balance: state.wallet.balance + event.amount,
        transactions: [transaction, ...state.wallet.transactions],
      );
      
      emit(state.copyWith(
        wallet: updatedWallet,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  void _onTransferSoutraWallet(
    TransferSoutraWallet event,
    Emitter<SoutraWalletState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    
    try {
      // Vérifier si le solde est suffisant
      if (state.wallet.balance < event.amount) {
        throw Exception('Solde insuffisant');
      }
      
      // Simuler un appel API pour transférer de l'argent
      await Future.delayed(const Duration(seconds: 1));
      
      // Créer une nouvelle transaction
      final transaction = SoutraTransaction(
        type: 'Transfert',
        amount: -event.amount, // Montant négatif car c'est un débit
        date: DateTime.now(),
        recipient: event.recipient,
        comment: event.comment,
      );
      
      // Mettre à jour le solde et ajouter la transaction
      final updatedWallet = state.wallet.copyWith(
        balance: state.wallet.balance - event.amount,
        transactions: [transaction, ...state.wallet.transactions],
      );
      
      emit(state.copyWith(
        wallet: updatedWallet,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
        isLoading: false,
      ));
    }
  }

  void _onToggleSoutraBalanceVisibility(
    ToggleSoutraBalanceVisibility event,
    Emitter<SoutraWalletState> emit,
  ) {
    emit(state.copyWith(showBalance: event.showBalance));
  }

  void _onAddSoutraTransaction(
    AddSoutraTransaction event,
    Emitter<SoutraWalletState> emit,
  ) {
    final updatedTransactions = [
      event.transaction,
      ...state.wallet.transactions
    ];
    
    // Mettre à jour le solde en fonction du type de transaction
    double updatedBalance = state.wallet.balance;
    if (event.transaction.type == 'Rechargement') {
      updatedBalance += event.transaction.amount;
    } else if (event.transaction.type == 'Transfert' || 
               event.transaction.type == 'Paiement') {
      updatedBalance -= event.transaction.amount;
    }
    
    final updatedWallet = state.wallet.copyWith(
      balance: updatedBalance,
      transactions: updatedTransactions,
    );
    
    emit(state.copyWith(wallet: updatedWallet));
  }
}
