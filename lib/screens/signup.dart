
import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:massenger/screens/LoginPage.dart';

import 'phone_verification.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  //Set Height/Width Using MediaQuery
  late double width;
  late double height;

  //Set Password Visiblity
  bool _isHidden = true;


  //Set Empty Data Validation
  final _formkey = GlobalKey<FormState>();

  //Set TextInput Controller
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _phoneCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/chatbg.jpg'),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: Size(width, height * 0.08),
              child: SafeArea(
                child: Container(
                  margin: EdgeInsets.only(
                      left: width * 0.05,
                      right: width * 0.05,
                      top: height * 0.02),
                  alignment: AlignmentDirectional.topStart,
                  child: InkWell(
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Icon(Icons.arrow_back_ios),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            body: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: SingleChildScrollView(
                    child: Center(
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: height * 0.04,
                                  left: width * 0.073,
                                  right: width * 0.073),
                              child: Text(
                                "Register yoour Account",
                                style: TextStyle(
                                    fontSize: width * 0.07,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: width * 0.020,
                                  right: width * 0.020,
                                  top: height * 0.027),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: height * 0.01,
                                        left: width * 0.05,
                                        right: width * 0.05),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 2),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextFormField(
                                      controller: _name,
                                      keyboardType: TextInputType.name,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp("[a-zA-Z ]")),
                                      ],
                                      textCapitalization:
                                          TextCapitalization.words,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Enter Name',
                                        hintStyle: TextStyle(
                                          fontSize: width * 0.04,
                                          color: Colors.black,
                                        ),
                                      ),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return (" please_enter_full_name");
                                        } else if (value.trim().length < 1) {
                                          return (" please_enter_valid_name");
                                        }
                                        return null;
                                      },
                                      onSaved: (String? name) {},
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: height * 0.01,
                                        left: width * 0.05,
                                        right: width * 0.05),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 2),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextFormField(
                                      controller: _email,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Enter Email',
                                        hintStyle: TextStyle(
                                          fontSize: width * 0.04,
                                          color: Colors.black,
                                        ),
                                      ),
                                      validator: (String? value) {
                                        Pattern pattern =
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                        RegExp regex =
                                            new RegExp(pattern as String);

                                        if (value!.length == 0) {
                                          return ("please_enter_email");
                                        }
                                        if (!regex.hasMatch(value)) {
                                          return ("please_enter_valid_email");
                                        }
                                        return null;
                                      },
                                      onSaved: (String? name) {},
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          width: width * 0.21,
                                          height: height * 0.06,
                                          margin: EdgeInsets.only(
                                            top: height * 0.01,
                                            left: width * 0.09,
                                            bottom: height * 0.03,
                                            // right: width * 0.05,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: width * 0.20,
                                                height: height * 0.07,
                                                margin: EdgeInsets.only(
                                                  top: height * 0.005,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  textAlign: TextAlign.center,
                                                  readOnly: true,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                  ),
                                                  controller: _phoneCode,
                                                  decoration: InputDecoration(
                                                    hintText: '+91',
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintStyle: TextStyle(
                                                      fontSize: width * 0.04,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    showCountryPicker(
                                                      context: context,
                                                      exclude: <String>[
                                                        'KN',
                                                        'MF'
                                                      ],
                                                      showPhoneCode: true,
                                                      onSelect:
                                                          (Country country) {
                                                        _phoneCode.text = "+" +
                                                            country.phoneCode;
                                                      },
                                                      countryListTheme:
                                                          const CountryListThemeData(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  40.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  40.0),
                                                        ),
                                                        inputDecoration:
                                                            InputDecoration(
                                                          labelText:
                                                              'register_phone_code_search',
                                                          hintText:
                                                              'register_typing_search',
                                                          prefixIcon: Icon(
                                                              Icons.search),
                                                          border:
                                                              OutlineInputBorder(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: width * 0.60,
                                          height: height * 0.085,
                                          margin: EdgeInsets.only(
                                            top: height * 0.01,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 2),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: TextFormField(
                                            controller: _phone,
                                            maxLength: 10,
                                            keyboardType:
                                                TextInputType.numberWithOptions(
                                                    decimal: true),
                                            inputFormatters: [
                                              new FilteringTextInputFormatter
                                                  .allow(RegExp("[0-9]")),
                                              LengthLimitingTextInputFormatter(
                                                  10)
                                            ],
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: '3309087555',
                                              hintStyle: TextStyle(
                                                fontSize: width * 0.04,
                                                color: Colors.black,
                                              ),
                                            ),
                                            validator: (String? value) {
                                              print(' ${value!.length}');
                                              if (value.isEmpty) {
                                                return ("please_enter_phone_no");
                                              }
                                              if (value.length != 10) {
                                                return ("please_enter_valid_number");
                                              }
                                              return null;
                                            },
                                            onSaved: (String? name) {},
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: height * 0.01,
                                        left: width * 0.05,
                                        right: width * 0.05),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 2),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextFormField(
                                      controller: _password,
                                      maxLength: 6,
                                      keyboardType: TextInputType.name,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[a-zA-Z0-9]'))
                                      ],
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: '*****',
                                        hintStyle: TextStyle(
                                          fontSize: width * 0.04,
                                          color: Colors.black,
                                        ),
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
                                        } else if (value.length < 6) {
                                          return ("Password should be = 6 Digits");
                                        }
                                        return null;
                                      },
                                      onSaved: (String? name) {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: height * 0.05,
                                  left: width * 0.05,
                                  right: width * 0.05,
                                  bottom: width * 0.05),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                width: width * 1.0,
                                height: height * 0.06,
                                child: ElevatedButton(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(fontSize: width * 0.045),
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    if (_formkey.currentState!.validate()) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PhoneVerification(
                                                      _phoneCode.text,
                                                      _phone.text)));
                                    } else {
                                      print("Unsuccessful");
                                      Fluttertoast.showToast(msg: "UnSuccesfull signUp");
                                    }
                                  },
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 50, bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Already have\'nt account?",
                                        style: TextStyle(
                                          fontSize: width * 0.035,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: width * 0.009),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage()));
                                          },
                                          child: Text("Login",
                                              style: TextStyle(
                                                  color: Colors.lightBlueAccent,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: width * 0.045)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
