import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../appbarwidgetbloc/appbarwidgetBloc.dart';
import '../appbarwidgetbloc/appbarwidgetEvent.dart';
import '../appbarwidgetbloc/appbarwidgetState.dart';

class AppbarItem extends StatelessWidget {

  final String title;
  const AppbarItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (_) => MenuBloc(),
          child: MyStatefulWidget(title: title),
        );
  }
}

class MyStatefulWidget extends StatelessWidget {

  final String title;
  const MyStatefulWidget ({required this.title});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size(92.0, 80.0)),
      child: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          return MouseRegion(
            onHover: (_) async {
              context.read<MenuBloc>().add(HoverMenuEvent());
              if (state is MenuVisibleState) {
                await showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(100, 100, 100, 100),
                  items: [
                    const PopupMenuItem(
                      child: Text("View"),
                    ),
                    const PopupMenuItem(
                      child: Text("Edit"),
                    ),
                    const PopupMenuItem(
                      child: Text("Delete"),
                    ),
                  ],
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: GestureDetector(
                onTap: () {
                  if ( title == "Métiers")
                  { context.go('/');  }
                  else if ( title == "Freelance" )
                  { print("Go to freelance");
                  context.go('/freelance'); }
                  else if ( title == 'Emarche' )
                  { print("Go to emarche");
                  context.go('/emarche');
                  }
                  else if ( title == "Autres" )
                  { context.go('/autre'); }
                  else if ( title == "A propos" )
                  { context.go('/'); }
                },
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16.0 , fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
