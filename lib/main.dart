import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sdealsapp/web/data/models/article.dart';
import 'package:sdealsapp/web/view/connexion/connexionbloc/connexionBloc.dart';
import 'package:sdealsapp/web/view/connexion/screens/connexionScreen.dart';
import 'package:sdealsapp/web/view/detailsarticle/detailsarticlebloc/detailsarticleBloc.dart';
import 'package:sdealsapp/web/view/detailsarticle/screens/detailsarticleScreen.dart';
import 'package:sdealsapp/web/view/detailsprestataire/detailsprestatairebloc/detailsprestataireBloc.dart';
import 'package:sdealsapp/web/view/detailsprestataire/screens/detailsprestataireScreen.dart';
import 'package:sdealsapp/web/view/emarche/emarchebloc/emarcheBloc.dart';
import 'package:sdealsapp/web/view/emarche/emarchebloc/emarcheEvent.dart';
import 'package:sdealsapp/web/view/emarche/screens/emarcheScreen.dart';
import 'package:sdealsapp/web/view/freelance/freelancebloc/freelanceBloc.dart';
import 'package:sdealsapp/web/view/freelance/freelancebloc/freelanceEvent.dart';
import 'package:sdealsapp/web/view/freelance/screens/freelanceScreen.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageBloc.dart';
import 'package:sdealsapp/web/view/homepage/homepagebloc/homePageEvent.dart';
import 'package:sdealsapp/web/view/homepage/screens/homePageScreen.dart';
import 'package:sdealsapp/web/view/prestataire/prestatairebloc/prestataireBloc.dart';
import 'package:sdealsapp/web/view/prestataire/screens/prestataireScreen.dart';

import 'mobile/view/homepagem/homepageblocm/homePageBlocM.dart';
import 'mobile/view/homepagem/homepageblocm/homePageEventM.dart';
import 'mobile/view/homepagem/screens/homePageScreenM.dart';
import 'mobile/view/splashcreen/screens/splashScreen.dart';
import 'mobile/view/splashcreen/splashscreenbloc/splashscreenBloc.dart';
import 'mobile/view/splashcreen/splashscreenbloc/splashscreenEvent.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter desktopRouter = GoRouter(
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
      GoRoute(
        path: '/detailsarticle',
        builder: (context, state) {
          final article = state.extra as Article;          return BlocProvider(
            create: (context) => DetailsArticleBloc(),
            child: DetailsArticleScreen(article: article),
          );
        },
      ),
      GoRoute(
        path: '/freelance',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => FreelanceBloc()..add(LoadCategorieDataF()),
            child: FreelanceScreen(),
          );
        },
      ),

    ],
  );


  final GoRouter mobileRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return BlocProvider(
          create: (_) => SplashscreenBloc()..add(LoadSplash()),
          child: SplashScreen(),
          );
        },
      ),
      GoRoute(
        path: '/homepage',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => HomePageBlocM()..add(LoadCategorieDataM()),
            child: HomePageScreenM(),
          );
        },
      ),

    ],
  );

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, sizingInformation)
    {
      GoRouter router;

      // Configure the router based on screen size
      if (sizingInformation.isDesktop) {
        router = desktopRouter;
      } else {
        router = mobileRouter;
      }
      return MaterialApp.router(
        routerConfig: router,
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
