import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../autrebloc/autreBloc.dart';



class AutreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final autreBloc = BlocProvider.of<AutreBloc>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Container
          (       padding : EdgeInsets.all(25),
            child : Row (   children:<Widget>[
              Image.asset('assets/logo.jpeg', width: 92,   // Largeur de l'image en pixels
                height: 76, ),
              Text( 'Soutrali Deals' , style: TextStyle ( fontSize: 27 , fontWeight: FontWeight.bold , color: Colors.black)) ,
            ]
            )
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Go to the next page', onPressed: () {  },
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: Text(
            'Home Page',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}