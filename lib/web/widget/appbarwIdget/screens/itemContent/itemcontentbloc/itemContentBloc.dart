import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/web/data/models/service.dart';


import '../../../../../data/models/categorie.dart';
import '../../../../../data/services/api_client.dart';
import 'itemContentEvent.dart';
import 'itemContentState.dart';

class ItemContentBloc extends Bloc<ItemContentEvent, ItemContentState> {

  ItemContentBloc() : super(ItemContentState.initial()) {
    on<LoadCategorieData>(_onLoadCategorieData);
  }

  Future<void> _onLoadCategorieData(LoadCategorieData event,
      Emitter<ItemContentState> emit,) async {
    // String nomgroupe = "Metiers";
    // emit(state.copyWith3(isLoading2: true));
    emit(state.copyWith(isLoading: true));
    ApiClient apiClient = ApiClient();
    print("Try");
    try {
      var nomgroupe = "Métiers" ;
      List<Categorie> list_categorie = await apiClient.fetchCategorie(nomgroupe);
      print("List Categorie");
      emit(state.copyWith(listItems: list_categorie, isLoading: false));
    } catch (error) {
      //   emit(state.copyWith3(error2: error.toString(), isLoading2: false));
      emit(state.copyWith(error: error.toString(), isLoading: false));
    }
  }

}


