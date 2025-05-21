import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../splashscreenblocm/splashscreenBlocM.dart';
import '../splashscreenblocm/splashscreenStateM.dart';


class SplashScreenM extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return BlocListener<SplashscreenBlocM, SplashscreenStateM>(
    listener: (context, state) {
      if (state is SplashLoadedM) {
        context.go('/homepage'); // Naviguer vers HomeScreen
      }
    },
    child: Scaffold(
      body: Center(
        child: BlocBuilder<SplashscreenBlocM, SplashscreenStateM>(
          builder: (context, state) {
            if (state is SplashLoadingM) {
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