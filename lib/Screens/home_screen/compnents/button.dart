import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../../providers/home_provider.dart';
class Button extends StatelessWidget{
  VoidCallback function ;
  Button({required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 30.0),
        width: 200.0,
        height: 50.0,
        child: ElevatedButton(
          onPressed: () => function(),
          child: const Text(
            "Continue",
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w700),
          ),
          style: ElevatedButton.styleFrom(
              shadowColor: Colors.black,
              onSurface: Colors.lightGreen,
              primary: Colors.lightGreen,
              elevation: 10.0,
              padding: EdgeInsets.all(10.0)),
        ));
  }




}