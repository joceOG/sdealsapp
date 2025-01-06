import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hover_menu/hover_menu.dart';
import 'package:hover_menu/hover_menu_lastitem.dart';
import 'package:sdealsapp/web/widget/appbarwIdget/screens/appbarItem.dart';


class NavigationItem extends StatelessWidget {

  final String title;
  const NavigationItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: AppbarItem (title: title,),
    );
  }
}