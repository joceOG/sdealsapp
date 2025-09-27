import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  const MyItemStatefulWidget({required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600, // Augmenter la hauteur
      child: BlocBuilder<ItemContentBloc, ItemContentState>(
        builder: (context, state) {
          return state.listItems == null
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Nombre de colonnes
                    crossAxisSpacing: 6, // Espacement horizontal
                    mainAxisSpacing: 6, // Espacement vertical
                    childAspectRatio:
                        0.8, // Réduire le ratio pour plus de hauteur
                  ),
                  itemCount: state.listItems!.length, // Nombre d'éléments
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.listItems![index].nomcategorie,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ContentDetailsScreen(
                              nomGroupe:
                                  state.listItems![index].groupe.nomgroupe,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
