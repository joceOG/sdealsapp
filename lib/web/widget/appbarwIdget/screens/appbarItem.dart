import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sdealsapp/web/widget/appbarwIdget/screens/itemContent/screens/itemContentScreen.dart';

import '../appbarwidgetbloc/appbarwidgetBloc.dart';
import '../appbarwidgetbloc/appbarwidgetEvent.dart';
import '../appbarwidgetbloc/appbarwidgetState.dart';

class AppbarItem extends StatelessWidget {
  final String title;
  const AppbarItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppBarWidgetBloc(),
      child: MyStatefulWidget(title: title),
    );
  }
}

class MyStatefulWidget extends StatelessWidget {
  final String title;
  const MyStatefulWidget({required this.title});
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size(92.0, 80.0)),
      child: BlocBuilder<AppBarWidgetBloc, AppBarWidgetState>(
        builder: (context, state) {
          return MouseRegion(
            onHover: (_) async {
              context
                  .read<AppBarWidgetBloc>()
                  .add(const HoverMenuEvent(nomgroupe: "Métiers"));
              if (title == "Métiers") {
                await showMenu(
                  context: context,
                  constraints: const BoxConstraints(
                    minWidth: 1200, // Set the desired width here
                    maxWidth: 1200,
                  ),
                  position: const RelativeRect.fromLTRB(100, 100, 100, 100),
                  items: [
                    PopupMenuItem(
                      enabled: false,
                      child: SizedBox(
                        width: 1100,
                        height: 600,
                        child: Row(
                          children: [
                            // Part 1: Elevated Button
                            SizedBox(
                              width: 350,
                              child: Container(
                                color: Color(0xFFDFEBE2),
                                child: Stack(children: [
                                  Positioned(
                                    top: 20,
                                    child: SizedBox(
                                      width: 350,
                                      height: 70,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                0), // Bords arrondis
                                          ),
                                        ),
                                        onPressed: () {
                                          // Handle button press
                                        },
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/business.png',
                                              width: 30,
                                            ),
                                            const SizedBox(width: 8),
                                            const Text(
                                                'Prestataires de services',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Jost',
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            const SizedBox(
                                width: 16), // Add spacing between parts
                            // Part 2: First List of Text
                            Expanded(
                              child: ItemContentScreen(title: title),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: GestureDetector(
                onTap: () {
                  if (title == "Métiers") {
                    context.go('/homepage');
                  } else if (title == "Freelance") {
                    print("Go to freelance");
                    context.go('/freelance');
                  } else if (title == 'Emarche') {
                    print("Go to emarche");
                    context.go('/emarche');
                  }
                },
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
