import 'package:equatable/equatable.dart';
import 'package:sdealsapp/web/data/models/categorie.dart';


abstract class ChatPageEventM extends Equatable {
  const ChatPageEventM();

  @override
  List<Object> get props => [];
}

class LoadCategorieDataM extends ChatPageEventM {}


