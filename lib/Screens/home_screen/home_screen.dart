import 'package:flutter/material.dart';

import 'home_body.dart';


class HomePageScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: HomeBody(),
      ),
    );
  }

}