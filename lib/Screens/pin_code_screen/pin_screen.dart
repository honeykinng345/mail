import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/home_provider.dart';
import 'compnents/pin_body.dart';
class PinScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final _home = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.white,
      body:Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child:PinBody() ,
      )
    );
  }

}