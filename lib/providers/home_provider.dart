import 'dart:ffi';

import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  var auth = FirebaseAuth.instance;
  late String Number, verificationId;
  bool showProgress = false;
  late String otp,
      authStatus = "";

  Future<String> RegisterUser(String Email) async {
    print("Done");
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: Email,
          password: "SuperSecretPassword!");
      return "Register Done";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak";
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return e.toString();
    }
    return "Something went wrong";
  }

  var acs = ActionCodeSettings(
    // URL you want to redirect back to. The domain (www.example.com) for this
    // URL must be whitelisted in the Firebase Console.
      url: 'https://flutterauthemail.page.link/',
      // This must be true
      handleCodeInApp: true,
      iOSBundleId: 'com.example.ios',
      androidPackageName: 'com.example.email.email_authenticatiom',
      // installIfNotAvailable
      androidInstallApp: true,
      // minimumVersion
      androidMinimumVersion: '12');

  Future<void> signInWithEmailAndLink(BuildContext context,String userEmail) async {
    return await auth.sendSignInLinkToEmail(
        email: userEmail, actionCodeSettings: acs)
        .catchError((onError) =>
        print('Error sending email verification $onError'))
        .then((value) => showDialou(context,'Successfully sent email verification'));
  }


  singWithEmail(String emailLink, String email) {
    if (auth.isSignInWithEmailLink(emailLink)) {
      // The client SDK will parse the code from the link for you.
      auth.signInWithEmailLink(email: email, emailLink: emailLink).then((
          value) {
        // You can access the new user via value.user
        // Additional user info profile *not* available via:
        // value.additionalUserInfo.profile == null
        // You can check if the user is new or existing:
        // value.additionalUserInfo.isNewUser;
        var userEmail = value.user;

        print('Successfully signed in with email link!');
      }).catchError((onError) {
        print('Error signing in with email link $onError');
      });
    }

// Confirm the link is a sign-in with email link.

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

  bool validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  bool validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return true;
    }
    else if (!regExp.hasMatch(value)) {
      return true;
    }
    return false;
  }

  Future<void> verifyPhoneNumber(BuildContext context,phoneNumber) async {
    Number = phoneNumber;
    try{
      showProgress = true;
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 15),
        verificationCompleted: (AuthCredential authCredential) {
          authStatus = "Your account is successfully verified";
        },

        codeAutoRetrievalTimeout: (String vid) {
          authStatus = "TIMEOUT";
          verificationId = vid;
        },
        verificationFailed: (FirebaseAuthException error) {
          authStatus = "Authentication failed";
        },
        codeSent: (String vid, int? forceResendingToken) {
          authStatus = "OTP has been successfully send";
          verificationId = vid;
        },

      );

    }on Error{

    }finally{
      showProgress = false;
    }

  }
}
