import 'package:equatable/equatable.dart';
import 'models/soutra_wallet_model.dart';

abstract class SoutraWalletEvent extends Equatable {
  const SoutraWalletEvent();

  @override
  List<Object> get props => [];
}

// Événement pour charger les données du portefeuille
class LoadSoutraWallet extends SoutraWalletEvent {}

// Événement pour activer le portefeuille
class ActivateSoutraWallet extends SoutraWalletEvent {}

// Événement pour recharger le portefeuille
class RechargeSoutraWallet extends SoutraWalletEvent {
  final double amount;
  final String method;
  final String? phoneNumber;

  const RechargeSoutraWallet({
    required this.amount, 
    required this.method,
    this.phoneNumber,
  });

  @override
  List<Object> get props => [amount, method, phoneNumber ?? ''];
}

// Événement pour transférer de l'argent
class TransferSoutraWallet extends SoutraWalletEvent {
  final double amount;
  final String recipient;
  final String? comment;

  const TransferSoutraWallet({
    required this.amount, 
    required this.recipient,
    this.comment,
  });

  @override
  List<Object> get props => [amount, recipient, comment ?? ''];
}

// Événement pour afficher/masquer le solde
class ToggleSoutraBalanceVisibility extends SoutraWalletEvent {
  final bool showBalance;

  const ToggleSoutraBalanceVisibility({required this.showBalance});

  @override
  List<Object> get props => [showBalance];
}

// Événement pour ajouter une nouvelle transaction
class AddSoutraTransaction extends SoutraWalletEvent {
  final SoutraTransaction transaction;

  const AddSoutraTransaction({required this.transaction});

  @override
  List<Object> get props => [transaction];
}
