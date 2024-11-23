import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/web/view/connexion/connexionbloc/connexionBloc.dart';
import 'package:sdealsapp/web/view/connexion/screens/connexionScreen.dart';
import 'package:sdealsapp/web/view/detailsprestataire/detailsprestatairebloc/detailsprestataireBloc.dart';
import 'package:sdealsapp/web/view/detailsprestataire/screens/detailsprestataireScreen.dart';
import 'package:sdealsapp/web/view/emarche/emarchebloc/emarcheBloc.dart';
import 'package:sdealsapp/web/view/emarche/emarchebloc/emarcheEvent.dart';
import 'package:sdealsapp/web/view/emarche/screens/emarcheScreen.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageBloc.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageEvent.dart';
import 'package:sdealsapp/web/view/homepage/screens/homePageScreen.dart';
import 'package:sdealsapp/web/view/prestataire/prestatairebloc/prestataireBloc.dart';
import 'package:sdealsapp/web/view/prestataire/screens/prestataireScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => HomePageBloc()..add(LoadCategorieData()),
            child: HomePageScreen(),
          );
        },
      ),
      GoRoute(
        path: '/connexion',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ConnexionBloc(),
            child: ConnexionScreen(),
          );
        },
      ),
      GoRoute(
        path: '/prestataire',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => PrestataireBloc(),
            child: PrestataireScreen(),
          );
        },
      ),
      GoRoute(
        path: '/detailsprestataire',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => DetailsPrestataireBloc(),
            child: DetailsPrestataireScreen(),
          );
        },
      ),
      GoRoute(
        path: '/emarche',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => EmarcheBloc()
              ..add(LoadCategorieEData())
              ..add(LoadServiceData()),
            child: EmarcheScreen(),
          );
        },
      ),

    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Soutrali Deals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(

            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1.5,
                )
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 1.5,
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey
                )
            ),
            hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14
            )
        ),

      ),

    );
  }
}




/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomePageBloc>(
          create: (context) => HomePageBloc()
        ),
      ],
      child: MaterialApp(
        title: 'Soutrali Deals',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(

              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.5,
                  )
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.5,
                  )
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey
                  )
              ),
              hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14
              )
          ),

        ),
        home: HomePageScreen(),
      ),
    );

  }
}

 */
