 import 'package:flutter/material.dart';
import 'package:down_detect/home%20page.dart';
import 'package:down_detect/sign%20in.dart';

import 'SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
@override
 State<MyApp> createState()=>_MyAppState();

  }
  class _MyAppState extends State<MyApp> {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute:LodingScreen.routeName,
        routes:{
          LoginScreen.routeName:(_)=>LoginScreen(),
          HomeScreen.routeName:(_)=>HomeScreen(),
          LodingScreen.routeName:(_)=>LodingScreen(),
        }

      );

        }
    }
