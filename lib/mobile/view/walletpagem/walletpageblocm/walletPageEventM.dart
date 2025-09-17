import 'package:equatable/equatable.dart';
import 'package:sdealsapp/data/models/categorie.dart';


abstract class WalletPageEventM extends Equatable {
  const WalletPageEventM();

  @override
  List<Object> get props => [];
}

class LoadCategorieDataM extends WalletPageEventM {}


