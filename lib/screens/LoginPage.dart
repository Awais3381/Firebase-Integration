import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:massenger/screens/homescreen.dart';
import 'package:massenger/screens/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _isHidden = true;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/background.jpg'),
        fit: BoxFit.cover,
      )),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // appBar: AppBar(
          //   title: Text("login Page"),
          //   backgroundColor: const Color(0xFF0093b5),
          // ),
          body: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, left: 110),
                        child: Text(
                          "Wellcome User",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 250, left: 30),
                        child: Text(
                          "Login to your Account",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 300, left: 20, right: 20),
                          child: SingleChildScrollView(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      controller: _email,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      textAlign: TextAlign.start,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Enter Email',
                                        suffixIcon: Icon(
                                          Icons.email_outlined,
                                          color: Colors.grey,
                                        ),
                                        hintStyle: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                      validator: (String? value) {
                                        Pattern pattern =
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                        RegExp regex = new RegExp(pattern as String);
                                        if (value!.length == 0) {
                                          return ("Please Enter your email");
                                        }
                                        if (!regex.hasMatch(value)) {
                                          return ("Please Enter valid email");
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    margin: EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: TextFormField(
                                      controller: _password,
                                      keyboardType: TextInputType.name,
                                      textInputAction: TextInputAction.done,
                                      inputFormatters:[FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]'))],
                                      style: TextStyle(fontSize: 16, color: Colors.black),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '******',
                                        hintStyle: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _isHidden
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isHidden = !_isHidden;
                                            });
                                          },
                                        ),
                                      ),
                                      obscureText: _isHidden,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return ("Enter Password");
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Container(
                        width: 90,
                        margin: EdgeInsets.only(top: 430,left: 140,),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:  Colors.white,
                          ),
                          child: Text("Login",style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Color(0xFF0093b5),
                          ),),
                          onPressed: (){

                            var email = _email.text;
                            var password = _password.text;
                            print("LOGIN CREDENTIAL::");
                            print("Email:" + email);
                            print("Password:" + password);

                            signIn(_email.text,
                                _password.text);
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.symmetric(vertical: 70),
                    child: RichText(
                      text: TextSpan(
                          text: 'Already Have an acount?',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                          children: [
                            TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: Color(0xFF0093b5),
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CreateAccount()));
                                  }),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
   signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
        Fluttertoast.showToast(msg: "Loginin Succesfully"),
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage())),
      })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
