import 'package:equatable/equatable.dart';
import 'package:sdealsapp/web/data/models/categorie.dart';


abstract class FreelancePageEventM extends Equatable {
  const FreelancePageEventM();

  @override
  List<Object> get props => [];
}

class LoadCategorieDataM extends FreelancePageEventM {}


