import 'package:flaskapp/components/roundButton.dart';
import 'package:flaskapp/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "registrationScreen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  bool showSpinner = false;
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
                    hintText: "Enter your email."
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration:inputDecorationStyle.copyWith(
                    hintText: "Enter your password."
                  )
                  ),
                SizedBox(
                  height: 24.0,
                ),
                RoundButton(
                    label: "Register", buttonColor: Colors.blueAccent,
                    onPressed: () async{
                      setState(() {
                        showSpinner = true;
                      });
                    try{
                      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                      Navigator.pushNamed(context, ChatScreen.id);
                      setState(() {
                        showSpinner = false;
                      });
                    }
                    catch(e){
                      print(e);
                      setState(() {
                        showSpinner = false;
                      });
                    }

                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
