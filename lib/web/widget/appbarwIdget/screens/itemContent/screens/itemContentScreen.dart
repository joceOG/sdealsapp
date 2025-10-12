import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdealsapp/web/widget/appbarwIdget/screens/itemContent/contentdetails/screens/contentDetailsScreen.dart';
import 'package:sdealsapp/web/view/freelance/freelancebloc/freelanceBloc.dart';
import 'package:sdealsapp/web/view/freelance/freelancebloc/freelanceEvent.dart';
import 'package:sdealsapp/web/view/freelance/freelancebloc/freelanceState.dart';
import 'package:sdealsapp/web/view/emarche/emarchebloc/emarcheBloc.dart';
import 'package:sdealsapp/web/view/emarche/emarchebloc/emarcheEvent.dart';
import 'package:sdealsapp/web/view/emarche/emarchebloc/emarcheState.dart';

import '../itemcontentbloc/itemContentBloc.dart';
import '../itemcontentbloc/itemContentState.dart';
import '../itemcontentbloc/itemContentEvent.dart';

class ItemContentScreen extends StatelessWidget {
  final String title;
  const ItemContentScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    // Utiliser le bon BLoC selon le titre
    if (title == "Freelance") {
      return BlocProvider(
        create: (_) => FreelanceBloc()..add(LoadCategorieDataF()),
        child: MyItemStatefulWidget(title: title),
      );
    } else if (title == "Emarche") {
      return BlocProvider(
        create: (_) => EmarcheBloc()..add(LoadCategorieEData()),
        child: MyItemStatefulWidget(title: title),
      );
    } else {
      // Par défaut pour "Métiers"
      return BlocProvider(
        create: (_) => ItemContentBloc()..add(LoadCategorieData()),
        child: MyItemStatefulWidget(title: title),
      );
    }
  }
}

class MyItemStatefulWidget extends StatelessWidget {
  final String title;
  const MyItemStatefulWidget({required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600, // Augmenter la hauteur
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (title == "Freelance") {
      return BlocBuilder<FreelanceBloc, FreelanceState>(
        builder: (context, state) {
          return state.listItems == null
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: state.listItems!.length,
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
      );
    } else if (title == "Emarche") {
      return BlocBuilder<EmarcheBloc, EmarcheState>(
        builder: (context, state) {
          return state.listItems == null
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: state.listItems!.length,
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
      );
    } else {
      // Par défaut pour "Métiers"
      return BlocBuilder<ItemContentBloc, ItemContentState>(
        builder: (context, state) {
          return state.listItems == null
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: state.listItems!.length,
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
      );
    }
  }
}
