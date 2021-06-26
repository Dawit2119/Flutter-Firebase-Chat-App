import 'package:flaskapp/components/roundButton.dart';
import 'package:flaskapp/screens/registration_screen.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcomeScreen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{
  dynamic controller;
  Animation? borderRadiusAnimation;
  Animation? backgroundAnimation;

  @override
  void initState() {
    // TODO: implement initState
      super.initState();
      controller = AnimationController(
        duration: Duration(seconds: 6),

        vsync:this,

      );
      backgroundAnimation = ColorTween(begin: Colors.blueGrey,end:Colors.white).animate(controller);
      borderRadiusAnimation = BorderRadiusTween(begin: BorderRadius.circular(3),end: BorderRadius.circular(30)).animate(controller);
      controller!.forward();

      controller!.addListener(() {

        setState(() {
        });
      });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText
                      (
                      "Flash Chat",
                      textStyle: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold
                      ),
                      speed: Duration(milliseconds: 100),
                    )
                  ],
                  pause: Duration(milliseconds: 1000),
                  // displayFullTextOnTap: true,
                  // stopPauseOnTap: true,

                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundButton(label: "Log In", buttonColor: Colors.lightBlue, onPressed: (){Navigator.pushNamed(context, LoginScreen.id);}),
            RoundButton(label: "Register", buttonColor: Colors.blueAccent, onPressed: (){Navigator.pushNamed(context, RegistrationScreen.id);}),

          ],
        ),
      ),
    );
  }
}

