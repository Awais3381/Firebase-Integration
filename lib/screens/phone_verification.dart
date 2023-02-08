import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'homescreen.dart';

class PhoneVerification extends StatefulWidget {
  final String phone;
  final String phonecode;

  PhoneVerification(this.phonecode, this.phone);

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  TextEditingController _controller = TextEditingController();
  late String _verficationcode;
  int? smsCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PHONE VEREFICATION",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Column(
                children: [
                  Text(
                    "Your phone verification Code \n  sent to your phone Number",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "${widget.phonecode}  ${widget.phone}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      margin: EdgeInsets.only(left: 70),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: '------',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            // labelText: 'Otp Code',
                            hintStyle: TextStyle(
                              wordSpacing: 12,
                              letterSpacing: 12,
                              fontSize: 50,
                            )),
                        controller: _controller,
                        onChanged: (text) {},
                        // onChanged: (input) => _controller.smsSent.value = input,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 100),
                      child: ElevatedButton(
                        onPressed: () async {
                          print(_controller.text);
                          print(_verficationcode);
                          print(smsCode);
                          try{
                           await FirebaseAuth.instance
                               .signInWithCredential(
                               PhoneAuthProvider.credential(
                                   verificationId: _verficationcode,
                                   smsCode: _controller.text))
                               .then((value) async {
                             if (value.user != null) {
                               Fluttertoast.showToast(msg: "OTP Verified succesfully");
                             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomePage()), (route) => false);
                             }
                           });
                         }
                         catch (e){
                           print("error here");
                         }
                        },
                        child: Text(
                          "verify",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlue,
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  _verifyphone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '${widget.phonecode}${widget.phone}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) async {
          if (value.user != null) {
            Fluttertoast.showToast(msg: "Login Succesfully");
            // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomePage()), (route) => false);
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
        // Fluttertoast.showToast("error" + e.message);
      },
      codeSent: (String verficationId, int? resendToken) {
        setState(() {
          _verficationcode = verficationId;
        });
      },
      codeAutoRetrievalTimeout: (String verficationId) {
        setState(() {
          _verficationcode = verficationId;
        });
      },
      timeout: Duration(seconds: 60),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyphone();
  }
}
