import 'package:flutter/material.dart';


class NavigationItem extends StatelessWidget {

  final String title;

  const NavigationItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 16.0 , fontWeight: FontWeight.bold),
      ),
    );
  }
}