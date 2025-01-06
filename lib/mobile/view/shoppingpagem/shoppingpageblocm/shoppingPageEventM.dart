import 'package:equatable/equatable.dart';
import 'package:sdealsapp/web/data/models/categorie.dart';


abstract class ShoppingPageEventM extends Equatable {
  const ShoppingPageEventM();

  @override
  List<Object> get props => [];
}

class LoadCategorieDataM extends ShoppingPageEventM {}


