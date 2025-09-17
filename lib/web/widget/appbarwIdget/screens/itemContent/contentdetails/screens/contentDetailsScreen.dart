import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../contentdetailsbloc/contentDetailsBloc.dart';
import '../contentdetailsbloc/contentDetailsState.dart';
import '../contentdetailsbloc/contentDetailsEvent.dart';

class ContentDetailsScreen extends StatelessWidget {

  final String nomGroupe;
  const ContentDetailsScreen({required this.nomGroupe});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContentDetailsBloc()..add(LoadServiceData(nomGroupe: this.nomGroupe)),
      child: const MyItemStatefulWidget(),
    );
  }
}

class MyItemStatefulWidget extends StatelessWidget {

  const MyItemStatefulWidget ();
  @override
  Widget build(BuildContext context) {
    return Container (
      height: 250,
      child: BlocBuilder<ContentDetailsBloc, ContentDetailsState>(
        builder: (context, state) {
          return
            state.listItems == null ?
            Center(child: CircularProgressIndicator()) :
            ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.listItems!.length, // Number of images
              itemBuilder: (context, index) {
                return Stack(
                    children: [
                      Text (
                        state.listItems![index].nomservice ,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ]
                );
              },
            );
        },
      ),
    );
  }
}
