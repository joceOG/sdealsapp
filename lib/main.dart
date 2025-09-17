import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:sdealsapp/data/models/article.dart';
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
import 'package:sdealsapp/web/view/inscription/inscriptionbloc/inscriptionBloc.dart';
import 'package:sdealsapp/web/view/inscription/screens/inscriptionScreen.dart';
import 'package:sdealsapp/web/view/prestataire/prestatairebloc/prestataireBloc.dart';
import 'package:sdealsapp/web/view/prestataire/screens/prestataireScreen.dart';
import 'package:sdealsapp/web/view/splashcreen/screens/splashScreen.dart';
import 'package:sdealsapp/web/view/splashcreen/splashscreenbloc/splashscreenBloc.dart';
import 'package:sdealsapp/web/view/splashcreen/splashscreenbloc/splashscreenEvent.dart';
import 'data/models/categorie.dart';
import 'data/services/authCubit.dart';
import 'mobile/view/home.dart';
import 'mobile/view/loginpagem/loginpageblocm/loginPageBlocM.dart';
import 'mobile/view/loginpagem/screens/loginPageScreenM.dart';
import 'mobile/view/registerpagem/registerpageblocm/registerPageBlocM.dart';
import 'mobile/view/registerpagem/screens/registerPageScreenM.dart';
import 'mobile/view/serviceproviderregistrationpagem/screens/serviceProviderRegistrationScreenM.dart';
import 'mobile/view/serviceproviderregistrationpagem/serviceproviderregistrationoageblocm/serviceProviderRegistrationPageBlocM.dart';
import 'mobile/view/serviceproviderwelcomepagem/screens/serviceProviderWelcomeScreenM.dart';
import 'mobile/view/shoppingpagem/screens/productDetailsScreenM.dart';
import 'mobile/view/shoppingpagem/shoppingpageblocm/shoppingPageBlocM.dart';
import 'mobile/view/shoppingpagem/shoppingpageblocm/shoppingPageEventM.dart'
as shoppingPageEventM;
import 'mobile/view/splashcreenm/screens/splashScreenM.dart';
import 'mobile/view/splashcreenm/splashscreenblocm/splashscreenBlocM.dart';
import 'mobile/view/splashcreenm/splashscreenblocm/splashscreenEventM.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await initializeDateFormatting('fr_FR', null);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter desktopRouter = GoRouter(
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
            create: (context) => HomePageBloc()..add(LoadCategorieData()),
            child: const HomePageScreen(),
          );
        },
      ),
      GoRoute(
        path: '/connexion',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ConnexionBloc(),
            child: const ConnexionScreen(),
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
              ..add(LoadServiceEData()),
            child: EmarcheScreen(),
          );
        },
      ),
      GoRoute(
        path: '/detailsarticle',
        builder: (context, state) {
          final article = state.extra as Article;
          return BlocProvider(
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
            child: const FreelanceScreen(),
          );
        },
      ),
      GoRoute(
        path: '/inscription',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => InscriptionBloc(),
            child: InscriptionScreen(),
          );
        },
      ),
      GoRoute(
          path: "/ProductDetails",
          builder: (context, state) {
            return BlocProvider(
              create: (context) => ShoppingPageBlocM()
                ..add(shoppingPageEventM.LoadCategorieDataM()),
              child: const ProductDetails(),
            );
          }),
    ],
  );

  final GoRouter mobileRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => SplashscreenBlocM()..add(LoadSplashM()),
            child: SplashScreenM(),
          );
        },
      ),
      GoRoute(
        path: '/homepage',
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => RegisterPageBlocM(),
            child: RegisterPageScreenM(),
          );
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) {
          return BlocProvider(
            create: (context) => LoginPageBlocM(),
            child: LoginPageScreenM(),
          );
        },
      ),
      GoRoute(
        path: '/serviceProviderWelcome',
        builder: (context, state) {
          final categories = state.extra as List<dynamic>; // cast to your type
          return ServiceProviderWelcomeScreenM(categories: categories);
        },
      ),
      GoRoute(
        path: '/serviceProviderRegistration',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => ServiceProviderRegistrationBlocM(),
            child: const ServiceProviderRegistrationScreenM(),
          );
        },
      ),
    ],
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // 👇 AuthCubit global pour toute l’application
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(),
        ),
      ],
      child: ResponsiveBuilder(builder: (context, sizingInformation) {
        GoRouter router =
        sizingInformation.isDesktop ? desktopRouter : mobileRouter;

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
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.5,
                    )),
                focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14)),
          ),
        );
      }),
    );
  }
}
