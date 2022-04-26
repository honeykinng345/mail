import 'package:flutter/material.dart';


class PinScreenHeader extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "We've Send you a code",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold,fontSize: 23.0),
                ),
              )
            ],
          ),
        ),
        const Text(
          "Enter the confirmation code below",
          style:
          TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
        )
      ],
    );
  }

}