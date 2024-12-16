import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../appbarwidgetbloc/appbarwidgetBloc.dart';
import '../appbarwidgetbloc/appbarwidgetEvent.dart';
import '../appbarwidgetbloc/appbarwidgetState.dart';

class AppbarItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
          create: (_) => MenuBloc(),
          child: MyStatefulWidget(),

        );
  }
}

class MyStatefulWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size(300.0, 200.0)),
      child: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          return MouseRegion(
            onHover: (_) { context.read<MenuBloc>().add(HoverMenuEvent()) ;
               print('Mouse') ;
              } ,
            child: GestureDetector(
              onTap: () async {
                if (state is MenuVisibleState) {
                  await showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(100, 100, 100, 100),
                    items: [
                      PopupMenuItem(
                        child: Text("View"),
                      ),
                      PopupMenuItem(
                        child: Text("Edit"),
                      ),
                      PopupMenuItem(
                        child: Text("Delete"),
                      ),
                    ],
                  );
                }
              },
              child: Container(
                color: Colors.lightBlueAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Hover over this box to show menu'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
