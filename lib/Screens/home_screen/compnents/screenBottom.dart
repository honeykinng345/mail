import 'package:email_authenticatiom/Screens/home_screen/compnents/screen_header.dart';
import 'package:flutter/material.dart';
class Bottom extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return  Column(

     mainAxisAlignment: MainAxisAlignment.end,
     children: [
       ScreenHeader(),
       Align(
         alignment: Alignment.bottomCenter,
         child: RaisedButton(
           onPressed: () => onClick(),
           child: const Text('Sample Button'),
           textColor: Colors.white,
           color: Colors.green,
           padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
         ),
       ),
     ],
   );
  }

  onClick() {}

}