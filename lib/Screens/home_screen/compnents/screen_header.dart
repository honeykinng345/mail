import 'package:flutter/material.dart';


class ScreenHeader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Icon(
                  Icons.arrow_back,
                  size: 30.0,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text(
                  "Connect your Wallet",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold,fontSize: 23.0),
                ),
              )
            ],
          ),
        ),
        const Text(
          "We'll Send you a confirmation code",
          style:
          TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        )
      ],
    );
  }

}