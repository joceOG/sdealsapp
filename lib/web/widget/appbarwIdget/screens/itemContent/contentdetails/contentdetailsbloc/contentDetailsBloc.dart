import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/web/data/models/service.dart';


import '../../../../../../data/models/categorie.dart';
import '../../../../../../data/services/api_client.dart';
import 'contentDetailsEvent.dart';
import 'contentDetailsState.dart';

class ContentDetailsBloc extends Bloc<ContentDetailsEvent, ContentDetailsState> {

  ContentDetailsBloc() : super(ContentDetailsState.initial()) {
    on<LoadServiceData>(_onLoadServiceData);
  }

  Future<void> _onLoadServiceData(LoadServiceData event,
      Emitter<ContentDetailsState> emit,) async {

    emit(state.copyWith(isLoading: true));
    ApiClient apiClient = ApiClient();
    print("Try");
    try {
      var categorieid = event.categorieid ;
      List<Service> list_service = await apiClient.fetchService(categorieid);
      print("List Categorie");
      emit(state.copyWith(listItems: list_service, isLoading: false));
    } catch (error) {
      //   emit(state.copyWith3(error2: error.toString(), isLoading2: false));
      emit(state.copyWith(error: error.toString(), isLoading: false));
    }
  }
}


