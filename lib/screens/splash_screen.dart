import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:updateproject/screens/login.dart';
import 'home.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController animController;
  Animation<double> animation;

  AnimationController backgroundAnimController;
  Animation<double> backgroundAnimation;

  @override
  void initState() {
    super.initState();

    loginCheck();

    backgroundAnimController = AnimationController(duration: Duration(milliseconds: 900), vsync: this);
    animController = AnimationController(duration: Duration(milliseconds: 1900), vsync: this);

    animation = Tween(begin: 0.0, end: 0.97).animate(animController)
      ..addListener(() {
        setState(() {});
      });
    backgroundAnimation = Tween(begin: 0.0, end: 1.0).animate(backgroundAnimController)
      ..addListener(() {
        setState(() {});
      });

    animController.forward();
    backgroundAnimController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animController.dispose();
    backgroundAnimController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final background = FadeTransition(opacity: backgroundAnimation, child: Container(color: Colors.white));
    final logo =
        FadeTransition(opacity: animation, child: new Image.asset("assets/images/logo.png", width: 150.0, height: 150.0));

    return new Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[background, Center(child: logo)]),
    );
  }

  loginCheck() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if (user != null) {
      navigation(Home());
    } else {
      navigation(LogIn());
    }
  }

  navigation(Widget page) {
    new Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            )));
  }
}
