import 'package:equatable/equatable.dart';
import 'models/soutra_wallet_model.dart';

class SoutraWalletState extends Equatable {
  final SoutraWalletModel wallet;
  final bool isLoading;
  final bool showBalance;
  final String? error;

  const SoutraWalletState({
    required this.wallet,
    this.isLoading = false,
    this.showBalance = true,
    this.error,
  });

  factory SoutraWalletState.initial() {
    return SoutraWalletState(
      wallet: const SoutraWalletModel(),
      isLoading: false,
      showBalance: true,
    );
  }

  SoutraWalletState copyWith({
    SoutraWalletModel? wallet,
    bool? isLoading,
    bool? showBalance,
    String? error,
  }) {
    return SoutraWalletState(
      wallet: wallet ?? this.wallet,
      isLoading: isLoading ?? this.isLoading,
      showBalance: showBalance ?? this.showBalance,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [wallet, isLoading, showBalance, error];
}
