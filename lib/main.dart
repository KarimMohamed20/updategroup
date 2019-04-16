import 'package:flutter/material.dart';
import 'package:updateproject/screens/splash_screen.dart';

void main() {
  runApp(MaterialApp(
      title: 'Update group',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        buttonColor: Colors.orange[800],
        accentColor: Colors.orange[800],
        textSelectionColor: Colors.orange[800],
        indicatorColor: Colors.orange[800],
        highlightColor: Colors.grey[400],
        splashColor: Colors.orange,
        
        primaryColor: Colors.orange,
      ),
      home: SplashScreen(),
    ));
}
