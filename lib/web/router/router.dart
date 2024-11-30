import 'package:flutter_bloc/flutter_bloc.dart';

// Define navigation events
abstract class NavigationEvent {}

class GoToHome extends NavigationEvent {}
class GoToConnexion extends NavigationEvent {}
class GoToPrestataire extends NavigationEvent {}
class GoToDetailsPrestataire extends NavigationEvent {}
class GoToEmarche extends NavigationEvent {}
class GoToDetailsArticle extends NavigationEvent {}

// Define the Bloc for navigation
class NavigationBloc extends Bloc<NavigationEvent, String> {
  NavigationBloc() : super('/home');

  @override
  Stream<String> mapEventToState(NavigationEvent event) async* {
    if (event is GoToHome) {
      yield '/home';
    } else if (event is GoToConnexion) {
      yield '/connexion';
    } else if (event is GoToPrestataire) {
      yield '/prestataire';
    } else if (event is GoToDetailsPrestataire) {
      yield '/detailsprestataire';
    } else if (event is GoToEmarche) {
    yield '/emarche';
    } else if (event is GoToEmarche) {
      yield '/detailsarticle';
    }

  }
}