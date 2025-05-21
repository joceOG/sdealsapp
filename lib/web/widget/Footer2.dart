import 'package:flutter/material.dart';

class Footer2 extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(
        top: 2.0,
      ),
      color: Colors.black,
      child:   Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Column(
              children: [
                Image.asset('assets/logo1.png',
                width: 300,),
                const Text('© Soutrali Deals 2024',
                style: TextStyle(
                  fontFamily: 'Jost',
                  color: Colors.white,
                  fontSize: 15,
                ),)
              ],
            )
            )
          ],
        )
    );
  }
}