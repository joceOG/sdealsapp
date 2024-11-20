import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class NavigationItem extends StatelessWidget {

  final String title;

  const NavigationItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
              onTap: () {
               if ( title == "Métiers")
                 { context.go('/');  }
               else if ( title == "Freelance" )
                 { context.go('/freelance'); }
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
    );
  }
}