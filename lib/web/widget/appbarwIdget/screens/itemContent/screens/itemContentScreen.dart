import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/web/widget/appbarwIdget/screens/itemContent/contentdetails/screens/contentDetailsScreen.dart';

import '../itemcontentbloc/itemContentBloc.dart';
import '../itemcontentbloc/itemContentState.dart';
import '../itemcontentbloc/itemContentEvent.dart';

class ItemContentScreen extends StatelessWidget {

  final String title;
  const ItemContentScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemContentBloc()..add(LoadCategorieData()),
      child: MyItemStatefulWidget(title: title),
    );
  }
}

class MyItemStatefulWidget extends StatelessWidget {
  final String title;
  const MyItemStatefulWidget ({required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: BlocBuilder<ItemContentBloc, ItemContentState>(
        builder: (context, state) {
          return
            state.listItems == null ?
            const Center(child: CircularProgressIndicator()) :
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Nombre de colonnes
                crossAxisSpacing: 6, // Espacement horizontal
                mainAxisSpacing: 6, // Espacement vertical
                childAspectRatio: 1.0, // Ratio largeur/hauteur des éléments
              ),
              itemCount: state.listItems!.length, // Nombre d'éléments
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Text(
                          state.listItems![index].nomcategorie, style:
                        const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                        ),
                        ),
                        ContentDetailsScreen(categorieid: state.listItems![index].idcategorie)
                      ],
                    ),
                    const Spacer(),
                  ],
                );
              },
            );
        }
      ),
    );
  }
}
