import 'package:equatable/equatable.dart';

class SoutraWalletModel extends Equatable {
  final double balance;
  final bool isActivated;
  final List<SoutraTransaction> transactions;

  const SoutraWalletModel({
    this.balance = 0.0,
    this.isActivated = false,
    this.transactions = const [],
  });

  SoutraWalletModel copyWith({
    double? balance,
    bool? isActivated,
    List<SoutraTransaction>? transactions,
  }) {
    return SoutraWalletModel(
      balance: balance ?? this.balance,
      isActivated: isActivated ?? this.isActivated,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object> get props => [balance, isActivated, transactions];
}

class SoutraTransaction extends Equatable {
  final String type;
  final double amount;
  final DateTime date;
  final String? comment;
  final String? recipient;

  const SoutraTransaction({
    required this.type,
    required this.amount,
    required this.date,
    this.comment,
    this.recipient,
  });

  @override
  List<Object?> get props => [type, amount, date, comment, recipient];
}
