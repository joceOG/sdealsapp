import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../splashscreenbloc/splashscreenBloc.dart';
import '../splashscreenbloc/splashscreenState.dart';


class SplashScreen extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return BlocListener<SplashscreenBloc, SplashscreenState>(
    listener: (context, state) {
      if (state is SplashLoaded) {
        context.go('/homepage'); // Naviguer vers HomeScreen
      }
    },
    child: Scaffold(
      body: Center(
        child: BlocBuilder<SplashscreenBloc, SplashscreenState>(
          builder: (context, state) {
            if (state is SplashLoading) {
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(

                        image: DecorationImage(

                          image: AssetImage('assets/logo1.png'),

                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
            return Text('Welcome');
          },
        ),
      ),
    ),
  );
}
}