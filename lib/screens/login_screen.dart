import 'dart:io';

import 'package:flaskapp/components/roundButton.dart';
import 'package:flaskapp/constants.dart';
import 'package:flaskapp/screens/chat_screen.dart';
import 'package:flaskapp/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "loginScreen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool showSpinner =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: "logo",
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                    decoration: inputDecorationStyle.copyWith(
                      hintText: "Enter your email"
                    ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                    decoration:inputDecorationStyle.copyWith(
                      hintText: "Enter your Password"
                    )
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundButton(label: "Log In", buttonColor: Colors.lightBlue,
                    onPressed: () async{
                  setState(() {
                    showSpinner = true;
                  });
                      try {
                        final loggedUser = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                            SweetAlert.show(context,
                            title: "Login board",
                            subtitle: "success",
                            style: SweetAlertStyle.success
                            );
                            sleep(Duration(seconds: 1));
                            Navigator.pushNamed(context, ChatScreen.id);
                            setState(() {
                              showSpinner = false;
                            });

                      }catch(e){
                        SweetAlert.show(context,
                            title: "Login board",
                            subtitle: "Email or password is incorrect",
                            style: SweetAlertStyle.error);
                        setState(() {
                          showSpinner = false;
                        });}

}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
