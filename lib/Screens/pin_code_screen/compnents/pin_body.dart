import 'package:email_authenticatiom/Screens/pin_code_screen/compnents/pin_screen_header.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import 'package:provider/provider.dart';

import '../../../providers/home_provider.dart';
class PinBody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return PinBodyState();
  }


}

class PinBodyState extends State<PinBody>{
  TextEditingController controller = TextEditingController(text: "");
  String thisText = "";
  int pinLength = 6;
  bool hasError = false;
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: SafeArea(

        child: Column(
       // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget> [

          PinScreenHeader(),
          SizedBox(height: 30,),
          Padding(
            padding:  EdgeInsets.only(top: (60.0),left: 20.0),
            child: PinCodeTextField(
              autofocus: true,
              controller: controller,
              hideCharacter: true,
              highlight: true,
              highlightColor: Colors.grey,
              defaultBorderColor: Colors.black,
              hasTextBorderColor: Colors.grey,
              highlightPinBoxColor: Colors.white,
              maxLength: pinLength,
              hasError: hasError,
              maskCharacter: ".",
              onTextChanged: (text) {
                setState(() {

                  hasError = false;
                });
              },
              onDone: (text) {
                print("DONE $text");
               signIn(controller.text.toString());
                print("DONE CONTROLLER ${controller.text.toString()}");
              },
              pinBoxWidth: 50,
              pinBoxHeight: 64,
              hasUnderline: true,
              wrapAlignment: WrapAlignment.spaceAround,
              pinBoxDecoration:
              ProvidedPinBoxDecoration.defaultPinBoxDecoration,
              pinTextStyle: TextStyle(fontSize: 22.0),
              pinTextAnimatedSwitcherTransition:
              ProvidedPinBoxTextAnimation.scalingTransition,
//                    pinBoxColor: Colors.green[100],
              pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
//                    highlightAnimation: true,
              highlightAnimationBeginColor: Colors.black,
              highlightAnimationEndColor: Colors.white12,
              keyboardType: TextInputType.number,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Did’t receive a code? Wait for 57 sec",
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.normal,fontSize: 15.0),
            ),
          )
        ],
        ),
      ),
    );

  }
  Future<void> signIn(String otp) async {
    final _home = Provider.of<HomeProvider>(context, listen: false);
    // Create a PhoneAuthCredential with the code
    try{
      // Sign the user in (or link) with the credential
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _home.verificationId, smsCode: otp);
      print("Test token");

      await _home.auth.signInWithCredential(credential);
      print(_home.auth.currentUser?.uid);
      setState(() {
        showDialou(context,"Registered");
      });
    } on FirebaseAuthException catch(e){
      if(e.code == "invalid-verification-code"){
       setState(() {
         showDialou(context,e.toString());
       });
      }
    }


  }
  showDialou(BuildContext context ,String Message ){
    var alertDialog = AlertDialog(
      title: const Text("Alert"),
      content: Text(Message),
      actions: [

      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog);
  }
}