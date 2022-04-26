import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../providers/home_provider.dart';
import '../pin_code_screen/pin_screen.dart';
import 'compnents/button.dart';
import 'compnents/screen_header.dart';

import 'package:provider/provider.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomeBody> {
  Future<void> verifyPhoneNumber(BuildContext context, phoneNumber) async {
    final _home = Provider.of<HomeProvider>(context, listen: false);

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 15),
      verificationCompleted: (AuthCredential authCredential) {
        setState(() {
          _home.authStatus = "Your account is successfully verified";
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) =>  PinScreen()),
          // );
        });
      },
      codeAutoRetrievalTimeout: (String vid) {
        setState(() {
          _home.authStatus = "TIMEOUT";
          _home.verificationId = vid;
        });
      },
      verificationFailed: (FirebaseAuthException error) {
        setState(() {
          _home.authStatus = "Authentication failed";
        });
      },
      codeSent: (String vid, int? forceResendingToken) {
        setState(() {
          _home.authStatus = "OTP has been successfully send";
          _home.verificationId = vid;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PinScreen()),
          );
        });
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      if (data?.link != null) {
        handleLink(data?.link);
      }
      FirebaseDynamicLinks.instance.onLink;
    }
  }

  String UserName = '';

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            ScreenHeader(),
            const SizedBox(
              height: 130,
            ),
            Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 2.0, left: 20.0, right: 20.0),
                child: TextField(
                  onChanged: (val) {
                    UserName = val;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.grey),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      ),
                      labelText: 'Phone number or Email',
                      prefixIcon: Image.asset("assets/icons/united.png"),
                      hintText: 'Phone number or Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Button(
                function: () {
                  RegisterProcess(context, UserName);
                },
              ),
            ),
            const SizedBox(
              height: 130,
            ),
          ],
        ),
        //  Spacer(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "By signing up I agree to Zëdfi’s Privacy Policy and Terms of Use and allow Zedfi to use your information for future Marketing purposes.",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          ),
        )
      ],
    ));
  }

  RegisterProcess(BuildContext context, String UserEmail) async {
    final _home = Provider.of<HomeProvider>(context, listen: false);
    bool check = context.read<HomeProvider>().validateEmail(UserEmail);
    if (check) {
      print('Email  is not match');
      bool phoneCheck = context.read<HomeProvider>().validateMobile(UserEmail);
      if (phoneCheck) {
        print('Phone number is not match');
      } else {
        verifyPhoneNumber(context, UserEmail);
      }
    } else {
      await _home.signInWithEmailAndLink(context, UserEmail);
    }
  }

  handleLink(
    Uri? link,
  ) {
    final _home = Provider.of<HomeProvider>(context, listen: false);

    _home.singWithEmail(link.toString(), UserName);
  }
}
