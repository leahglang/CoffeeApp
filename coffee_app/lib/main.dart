import 'package:coffe_app/Model/coffee_shope.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/intro_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CoffeeShope(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroScreen(),
      ),
    );
  }
}


//1