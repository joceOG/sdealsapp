
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/mobile/view/rondpagem/rondpageblocm/rondPageStateM.dart';
import '../rondpageblocm/rondPageBlocM.dart';
import '../rondpageblocm/rondPageEventM.dart';



class RondPageScreenM extends StatefulWidget {
  const RondPageScreenM({super.key});
  @override
  State<RondPageScreenM> createState() => _RondPageScreenStateM();
}

class _RondPageScreenStateM extends State<RondPageScreenM> {
  @override
  void initState() {
    BlocProvider.of<RondPageBlocM>(context);
    super.initState();
  }
  Widget build(BuildContext context) {

    return const Scaffold(

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Corps principal de la page
            Text("Page Rond"),
          ],
        ),
      ),
    );

  }
}