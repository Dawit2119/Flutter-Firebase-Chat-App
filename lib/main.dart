import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flaskapp/screens/chat_screen.dart';
import 'package:flaskapp/screens/login_screen.dart';
import 'package:flaskapp/screens/registration_screen.dart';
import 'package:flaskapp/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(FlashChat());
}
class FlashChat extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
      routes: {
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        ChatScreen.id:(context)=>ChatScreen()

      },
    );
  }
}
