import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../contentdetailsbloc/contentDetailsBloc.dart';
import '../contentdetailsbloc/contentDetailsState.dart';
import '../contentdetailsbloc/contentDetailsEvent.dart';

class ContentDetailsScreen extends StatelessWidget {
  final String nomGroupe;
  const ContentDetailsScreen({required this.nomGroupe});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ContentDetailsBloc()..add(LoadServiceData(nomGroupe: this.nomGroupe)),
      child: const MyItemStatefulWidget(),
    );
  }
}

class MyItemStatefulWidget extends StatelessWidget {
  const MyItemStatefulWidget();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Réduire la hauteur
      child: BlocBuilder<ContentDetailsBloc, ContentDetailsState>(
        builder: (context, state) {
          return state.listItems == null
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.listItems!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        state.listItems![index].nomservice,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
